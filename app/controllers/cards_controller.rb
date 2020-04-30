class CardsController < ApplicationController
  require 'payjp'
  before_action :set_payjp_key, only: [:create, :show, :destroy]

  def new
    # カード情報を持ってるならカード情報表示のアクションにそのまま渡す
    card = current_user.card
    if card.present? && card.card_id.present?
      redirect_to action: :show
    end
  end

  def create
  end

  def show
  end

  def destroy
  end
  
  private
  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

end
