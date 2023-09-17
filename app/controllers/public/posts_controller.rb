class Public::PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(8)
    @posts = Post.all
    @customer = current_customer
  end
  
  def show
    @post = Post.find(params[:id])
    @customer = current_customer
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
  if @post.save
    flash[:notice] = "更新しました。"
    redirect_to posts_path
  else
    @posts = Post.all
    render :index
  end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end
  
  private

  def post_params
    params.require(:post).permit(:introduction, :image, :post_place)
  end
end
