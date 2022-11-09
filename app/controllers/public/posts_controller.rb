class Public::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_new = Post.new
    @comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      redirect_to root_path, notice: "投稿できませんでした"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to root_path, notice: "削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:spot_image, :address, :spot_name, :body)
  end
end
