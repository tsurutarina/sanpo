class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
  end

  def destroy
    #byebug
    current_customer.unfollow(params[:customer_id])
    @customer = Customer.find(params[:customer_id])
  end
  # フォロー一覧
  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = customer.followings
    @post = Post.new
  end
  # フォロワー一覧
  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = customer.followers
    @post = Post.new
  end

end
