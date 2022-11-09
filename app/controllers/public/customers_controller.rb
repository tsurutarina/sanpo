class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @post = Post.new
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer.id)
    end
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

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    # unless @customer == current_customer
    #   redirect_to customer_path(current_customer.id)
    # end
    # is_deletedをtrueに変更、削除フラグ立てる
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.nickname == "ゲストユーザー"
      redirect_to customer_path(current_customer.id), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
