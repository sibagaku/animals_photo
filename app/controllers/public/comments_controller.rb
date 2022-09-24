class Public::CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      render "comment"
    else
      @post = Post.find(params[:post_id])
      @post_comment = @comment
      @user = @post.user
      render template: "public/posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    render "comment"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end
