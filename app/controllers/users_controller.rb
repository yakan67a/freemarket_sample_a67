class UsersController < ApplicationController

  # 新規登録画面用
  def index
  end

  # マイページメイン画面用
  def show
  end

  # マイページからのログアウト用
  def logout
  end

  # プロフィール編集用
  def edit_profile
    @user = User.find(params[:id])
  end

  # プロフィール更新用
  def update_profile
  end

end
