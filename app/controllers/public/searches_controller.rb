class Public::SearchesController < ApplicationController

  def search
    @customers = Customer.active
    # @post = Post.active
    @range = params[:range]
    if @range == "スポット"
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc)
    else
      @customers = @customers.looks(params[:search], params[:word]).order(created_at: :desc)
    end
    @word = params[:word]
    @post = Post.new
  end
end
