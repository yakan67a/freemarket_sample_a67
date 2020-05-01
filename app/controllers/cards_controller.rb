class CardsController < ApplicationController
  require 'payjp'
  before_action :set_payjp_key, only: [:index, :create, :destroy]

  def index
    @card = current_user.card

    if @card.present? && @card.card_id.present?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(@card.card_id)
    end
  end

  def new
  end

  def create
    token = params["payjp-token"]
    if token.blank? # トークンの取得に失敗していたら戻る
      redirect_to action: :new
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
          redirect_to action: :index
        else
          redirect_to action: :new
        end
      else
      # ユーザーがcardテーブルを持っている場合の処理
      end
    end
  end

  def destroy 
    card = current_user.card
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.cards.retrieve(card.card_id).delete
    
    # レコード丸ごと削除するのではなく、card_idカラムをnullにします。顧客IDを保持させ続けるためです。
    card.update(card_id: nil)
    redirect_to action: :index
  end
  
  private
  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

end
