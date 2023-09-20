class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :comments
  
  def self.search(keyword)
    where("customer LIKE ? or post LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end
  
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
