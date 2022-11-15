class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to admin_root_path, notice: "削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:spot_image, :address_spot, :spot_name, :body)
  end

end
