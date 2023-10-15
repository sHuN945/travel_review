class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy

  def full_name
    self.last_name + " " + self.first_name
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = 'ゲスト'
      customer.first_name = 'カスタマー'
      customer.last_name_kana = 'ゲスト'
      customer.first_name_kana = 'カスタマー'
      customer.postal_code = '1111111'
      customer.address = '東京'
      customer.telephone_number = '11111111111'
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("last_name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("last_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("last_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("last_name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end


  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, presence: true

  def active_for_authentication?
    super && (is_deleted == nil)
  end

end
