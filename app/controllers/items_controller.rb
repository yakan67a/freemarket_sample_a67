class ItemsController < ApplicationController

def new
  @item = Item.new
  @item.item_images.new
end
end
