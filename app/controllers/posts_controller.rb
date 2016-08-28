class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, flash: { success: 'Post added' }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    if @post.delete
      redirect_to posts_path, flash: { success: 'Post deleted' }
    else
      redirect_to posts_path, flash: { alert: 'Oops' }
    end
  end

  def index
    @posts = Post.all.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id)
  end

  def pundit_user
    Post.find(params[:id]).user
  end
end
