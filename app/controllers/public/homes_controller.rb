class Public::HomesController < ApplicationController
  
  
  def top
    @customer = current_customer
    @post = Post.new
  end

  def about
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:list).permit(:title, :body, :image, :star)
  end
end
