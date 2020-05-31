class UsersController < ApplicationController

  before_action :set_user, except: :index

  # 新規登録画面用
  def index
  end

  # マイページメイン画面用
  def show
    @bought_items = current_user.bought_item
  end

  # マイページからのログアウト用
  def logout
  end

  # プロフィール編集用
  def edit_profile
  end

  # プロフィール更新用
  def update_profile
    if @user.update(user_params)
      redirect_to update_complete_user_path, notice: '更新しました'
    else
      flash.now[:error] = '更新失敗'
      render update_complete_user_path
    end
  end

  # 送付先住所編集用
  def edit_shipping_address
  end

  # 送付先住所更新用
  def update_shipping_address
    if @shipping_address.update(shipping_address_params)
      redirect_to update_complete_user_path, notice: '更新しました'
    else
      flash.now[:error] = '更新失敗'
      render :edit_shipping_address
    end
  end

  def update_complete
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :profile_image, :profile)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:name_first, :name_last, :name_first_kana, :name_last_kana, :zipcode, :prefecture_id, :city, :street_address, :building, :phone_number)
  end

  def set_user
    @user = User.find(params[:id])
    @shipping_address = ShippingAddress.find(params[:id])
  end

end
