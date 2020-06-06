class HomesController < ApplicationController
  def index
    @item = Item.limit(3).includes(:history, :item_images).order('created_at DESC')
    @parents  = Category.where(ancestry: nil)
  end

  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

end