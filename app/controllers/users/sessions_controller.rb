class Users::SessionsController < Devise::SessionsController
  # ゲストユーザー用記述
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path(user)
  end
end