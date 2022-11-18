class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @post = Post.new
    @posts = @customer.posts
    # いいね総カウント
    @customer_posts = @customer.posts
    @favorites_count = 0
    @customer_posts.each do |post|
      @favorites_count += post.favorites.count
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer.id), notice: "ユーザー情報を編集しました"
    else
      @customer = Customer.find(params[:id])
      render edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to root_path, notice: "ユーザーを削除しました"
    else
      @customer = Customer.find(params[:id])
      render edit
    end
  end

  def favorites
    @customers = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customers.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer.id)
    end
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to customer_path(current_customer.id), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません'
    end
  end

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
