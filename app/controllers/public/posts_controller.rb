class Public::PostsController < ApplicationController
    before_action :set_post, only: [:edit, :show]
    before_action :move_to_index, except: [:index, :show, :search]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: "DESC")
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.delete
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, images: [], tag_ids:[])
  end

end
