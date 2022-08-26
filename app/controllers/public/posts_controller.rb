class Public::PostsController < ApplicationController

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.save
      redirect_to post_path(@post.id)
    end

    def index
      if params[:introduction] == nil
        @post_all = Post.all
        @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:introduction] == ""
        @post_all = Post.all
        @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc)
      else
        @post_all = Post.where("introduction LIKE ?", "%#{params[:introduction]}%")
        @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc).where("introduction LIKE ?", "%#{params[:introduction]}%")
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
      @post.update(post_params)
      redirect_to post_path(@post.id)
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


end
