class Public::FavoritesController < ApplicationController

  def create
  end

  def destroy
  end

  def followings
    @post = Post.new
  end

  def followers
    @post = Post.new
  end

end
