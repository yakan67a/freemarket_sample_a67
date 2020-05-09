class TransactionController < ApplicationController

  def buy
    @item = Item.find(params[:item_id])
    @address = current_user.shipping_address
    @prefecture = Prefecture.find(@address.prefecture_id).name
  end

  def sold
  end

  def done
  end

  def error
  end

end
