class CardsController < ApplicationController
  require 'payjp'
  before_action :set_payjp_key, only: [:index, :create, :destroy]

  def index
    @card = current_user.card
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
  end
  
  private
  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

end
