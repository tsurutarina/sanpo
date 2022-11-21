class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_guest_customer, only: [:edit]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
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
      redirect_to admin_customer_path(@customer), notice: "ユーザー情報を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to admin_root_path, notice: "ユーザーを削除しました"
    else
      @customer = Customer.find(params[:id])
      render edit, notice: "ユーザーの削除ができませんでした"
    end
  end


  private

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to admin_customer_path(@customer), notice: 'ゲストユーザーはプロフィール編集できません'
    end
  end

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
