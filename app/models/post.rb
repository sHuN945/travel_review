class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :comments, dependent: :destroy
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("post_place LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("post_place LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("post_place LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("post_place LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
