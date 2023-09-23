class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :create]
  
  def index
    @posts = Post.page(params[:page]).per(8)
    @posts = Post.all
    @customer = current_customer
    if params[:new_post]
       @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @posts = @posts.page(params[:page])
    end
    @keyword = params[:keyword]
  end
  
  def edit
   @post = Post.find(params[:id])
  end
  
  def show
    @post = Post.find(params[:id])
    @customer = current_customer
    @comments = @post.comments
    @comment = Comment.new
  end
  
  def create
    @post = Post.new(post_params)
    @customer = current_customer
    @post.customer_id = current_customer.id
  if @post.save
    flash[:notice] = "投稿しました。"
    redirect_to posts_path
  else
    @posts = Post.all
    render :index
  end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post)
    else
      render :edit
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
