class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "スポット"
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc)
    else
      @customers = Customer.looks(params[:search], params[:word]).order(created_at: :desc)
    end
    @word = params[:word]
  end
end
