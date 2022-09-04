class Public::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to post_path(@post.id)
      else
        render :new
      end
    end

    def index
      @user
      if params[:introduction] == nil
        @post_all = Post.joins(:user).where(users:{is_deleted: false})
        @posts = Post.joins(:user).where(users:{is_deleted: false}).page(params[:page]).per(9).order(created_at: :desc)
      elsif params[:introduction] == ""
        @post_all = Post.joins(:user).where(users:{is_deleted: false})
        @posts = Post.joins(:user).where(users:{is_deleted: false}).page(params[:page]).per(9).order(created_at: :desc)
      else
        @post_all = Post.joins(:user).where(users:{is_deleted: false}).where("introduction LIKE ?", "%#{params[:introduction]}%")
        @posts = Post.joins(:user).where(users:{is_deleted: false}).page(params[:page]).per(9).order(created_at: :desc).where("introduction LIKE ?", "%#{params[:introduction]}%")
      end
    end

    def show
      @post = Post.find(params[:id])
      @user = @post.user
      @post_comment = Comment.new
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to post_path(@post.id)
      else
        render :edit
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to posts_path
    end

    private

    def post_params
      params.require(:post).permit(:introduction, :image)
    end

    def correct_user
      @post = Post.find(params[:id])
      @user = @post.user
      redirect_to(posts_path) unless @user == current_user
    end


end
