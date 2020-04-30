class CardsController < ApplicationController
  require 'payjp'
  before_action :set_payjp_key, only: [:index, :create, :destroy]

  def index
    @card = current_user.card
  end

  def new
  end

  def create
  end

  def destroy
  end
  
  private
  def set_payjp_key # payjpの秘密鍵をセットする
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

end
