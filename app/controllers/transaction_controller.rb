class TransactionController < ApplicationController
  require 'payjp'
  before_action :move_to_login
  before_action :set_payjp_key, only: :buy

  def buy
    @item = Item.find(params[:item_id]) 
    @address = current_user.shipping_address 
    @prefecture = Prefecture.find(@address.prefecture_id).name 

    # カード情報登録済みなら、カード情報してビューに渡します。
    card = current_user.card
    if card.present? && card.card_id.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_info = customer.cards.retrieve(card.card_id)
    end
  end

  def sold
  end

  def done
  end

  def error
  end
  
  private
  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

end
