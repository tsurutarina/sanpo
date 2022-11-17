class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :create, :destroy]

  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
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
    params.require(:post).permit(:spot_image, :address_spot, :spot_name, :body)
  end

end
