class TransactionController < ApplicationController
  require 'payjp'
  before_action :move_to_login
  before_action :set_item
  before_action :move_to_sold, only: [:buy, :pay]
  before_action :set_user_address, only: [:buy, :done]
  before_action :set_payjp_key, only: [:buy, :pay, :done, :card,:register_card]
  before_action :set_card_info, only: [:buy, :done, :card]

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
    token = params["payjp-token"]

    if token.blank? # トークンの取得に失敗していたらやりなおしを求める
      @error_message = "カードの登録に失敗しました。もう一度お試しください。"
      render :card, item_id: @item.id
    else
      if current_user.card.blank?
        # ユーザーがcardテーブルを持っていない場合の処理
        customer = Payjp::Customer.create(
          description: "test", 
          card: token, 
          metadata: {user_id: current_user.id}
          )

        card = Card.new(
          user_id: current_user.id, 
          customer_id: customer.id, 
          card_id: customer.default_card
          )
        
        if card.save
          redirect_to action: :buy, item_id: @item.id
        else
          @error_message = "カードの登録に失敗しました。もう一度お試しください。"
          render :card, item_id: @item.id
        end

      else
        # ユーザーがcardテーブルを持っている場合の処理
        card = current_user.card
        customer = Payjp::Customer.retrieve(card.customer_id)
        response = customer.cards.create(card: token, default: true)

        if card.update(card_id: response.id)
          redirect_to action: :buy, item_id: @item.id
        else
          @error_message = "カードの登録に失敗しました。もう一度お試しください。"
          render :card, item_id: @item.id
        end
      end
    end
  end

  def address
    @address = current_user.shipping_address
  end

  def update_address
    @address = current_user.shipping_address
    if @address.update(shipping_address_params)
      render action: :buy, user_id: @item.id
    else
      flash.now[:error] = '更新失敗'
      render action: :address, user_id: @item.id
    end
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

  def shipping_address_params
    params.require(:shipping_address).permit(:name_first, :name_last, :name_first_kana, :name_last_kana, :zipcode, :prefecture_id, :city, :street_address, :building, :phone_number)
  end
end
