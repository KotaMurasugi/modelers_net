class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
  end
end
