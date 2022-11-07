class Public::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      redirect_to root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to root_path, notice: "削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:body, :address,:spot_image)
  end
end
