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
      render :edit
    end
  end

  # def withdrawal
  #   @customer = Customer.find(params[:id])
  #   @customer.update(is_deleted: true)
  #   reset_session
  #   redirect_to admin_root_path, notice: "退会処理を実行しました"
  # end

  private
  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

end
