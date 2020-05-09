class HomesController < ApplicationController
  def index
    @item = Item.limit(3).includes(:history, :item_images).order('created_at DESC')
  end
end
