class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

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
      @customer = Customer.find(params[:id])
      render edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
