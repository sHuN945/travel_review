class Public::HomesController < ApplicationController
  before_action :authenticate_customer!
  
  def top
    @customer = current_customer
    @post = Post.new
  end

  def about
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to root_path
  end

  private
  def post_params
    params.require(:list).permit(:title, :body, :image)
  end
end
