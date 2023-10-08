class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
    @posts = Post.page(params[:page]).per(10)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end
end
