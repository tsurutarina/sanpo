class Public::HomesController < ApplicationController

  def about
    @posts = Post.order(created_at: :desc).limit(3)
  end
end
