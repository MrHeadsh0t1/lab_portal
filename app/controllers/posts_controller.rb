class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).order(created_at: :desc)

    if params[:search].present?
      search = "%#{ActiveRecord::Base.sanitize_sql_like(params[:search])}%"

      @posts = @posts.where(
        "title LIKE :search OR content LIKE :search",
        search: search
      )
    end

    if params[:category].present?
      @posts = @posts.where(category: params[:category])
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "Post deleted successfully."
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end