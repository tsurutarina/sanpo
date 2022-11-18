class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = @post.id
    if @comment.save
    else
      redirect_to post_path(@post), notice: "コメントの送信に失敗しました"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private

  def ensure_correct_customer
    @comment = PostComment.find(params[:id])
    unless @comment.customer == current_customer
      redirect_to customer_path(current_customer.id)
    end
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
