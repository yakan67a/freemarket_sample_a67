class HomesController < ApplicationController
  def index
    @item = Item.limit(3).order('created_at DESC')
    @history = History.all
  end
end
