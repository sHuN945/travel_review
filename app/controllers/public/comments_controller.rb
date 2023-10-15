class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @comment = Comment.new(comment_params)
    @comment.customer_id = current_customer.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  
  def index
    @comments = Comment.all
    @customer = current_customer
  end 
  
  def show
  end 
  
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Comment updated"
      redirect_to @post
    else
      flash[:danger] = "Comment failed"
      render 'edit'
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to '/comments'
  end 
  
  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
  
end
