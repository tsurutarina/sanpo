class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order(created_at: :desc)
    # いいね総カウント
    customer_posts = @customer.posts
    @favorites_count = 0
    customer_posts.each do |post|
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
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to root_path, notice: "退会しました"
    else
      render :edit
    end
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites)
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
    if @customer == Customer.guest
      redirect_to customer_path(current_customer.id), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません'
    end
  end

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
