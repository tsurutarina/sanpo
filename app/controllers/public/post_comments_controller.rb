class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.customer_id = current_customer.id
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), notice: "コメントを送信しました"
    else
      redirect_to post_path(@post), notice: "コメントの送信に失敗しました"
    end
  end

  def destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
