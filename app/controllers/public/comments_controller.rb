class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end
  
  def index
  end 
  
  def show
  end 
  
  def destroy
  end 
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
