class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :show, :create, :destroy]
  before_action :ensure_correct_customer, only: [:destroy]

  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to root_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: "削除しました"
  end

  private

  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:spot_image, :address_spot, :spot_name, :body)
  end

end
