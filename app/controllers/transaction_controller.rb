class TransactionController < ApplicationController
  require 'payjp'
  before_action :move_to_login
  before_action :set_item, only: [:buy, :pay, :sold, :done, :error]
  before_action :move_to_sold, only: [:buy, :pay]
  before_action :set_user_address, only: [:buy, :done]
  before_action :set_payjp_key, only: [:buy, :pay, :done]
  before_action :set_card_info, only: [:buy, :done]

  # 購入確認画面
  def buy
  end

  # 支払い処理
  def pay
    card = current_user.card
    # カードが削除されていないかチェックする (手順:購入確認画面を開いた状態で、別タブからカード情報を削除したあと、購入を確定する)
    redirect_to action: :error, item_id: @item.id and return unless card.card_id

    # 先にhistoryテーブルへ保存。PayjpAPIがエラーを返してきたらロールバックする。
    History.transaction do 
      History.create(user_id: current_user.id, item_id: @item.id)
      @result = Payjp::Charge.create(
        amount:   @item.price,
        customer: card.customer_id,
        currency: "jpy"
      )
      redirect_to action: :done, item_id: @item.id 
      return
    end
    rescue Payjp::CardError
    redirect_to action: :error, item_id: @item.id
    return
  end

  # 売り切れ時の処理
  def sold
  end

  # 購入完了画面
  def done
  end

  # payjpアクセスでのエラー時
  def error
  end

  def card
  end

  def register_card
  end

  def address
  end

  def update_address
  end
  
  private
  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_sold # インスタンス変数@itemを用いているためset_itemより後に呼び出す必要があります。
    redirect_to action: :sold, item_id: @item.id if @item.history
  end

  def set_user_address
    @address = current_user.shipping_address 
    @prefecture = Prefecture.find(@address.prefecture_id).name 
  end

  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

  def set_card_info # カード情報登録済みなら、カード情報を取得してビューに渡します。
    card = current_user.card 
    if card.present? && card.card_id.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_info = customer.cards.retrieve(card.card_id)
    end
  end

end
