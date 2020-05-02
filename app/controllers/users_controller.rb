class UsersController < ApplicationController

  # 新規登録画面用
  def index
  end

  # マイページメイン画面用
  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to update_complete_user_path, notice: '更新しました'
    else
      flash.now[:error] = '更新失敗'
      render update_complete_user_path
    end
  end

  def update_complete
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :profile_image, :profile)
  end

end
