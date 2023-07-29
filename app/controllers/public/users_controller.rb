class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :show]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: "DESC")
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorites = Post.find(favorites)
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to posts_path(current_user)
    end
  end
end
