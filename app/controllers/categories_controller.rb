class CategoriesController < ApplicationController

before_action :set_category, only: [:parent, :child, :grandchild]

def index
end


def parent
  children = @category.children
  grandchildren = []
  children.each do |child|
    grandchildren << Category.where(ancestry: "#{@category.id}/#{child.id}")
  end
  @items = []
  grandchildren.each do |grandchild|
    grandchild.each do |id|
      @items += Item.where(category_id: id)
    end
  end
  @categories = Category.where(ancestry: nil)
end

def child
  grandchildren = @category.children
  @items = []
  grandchildren.each do |grandchild|
    @items += Item.where(category_id: grandchild.id)
  end
end

def grandchild
  @items = Item.where(category_id: params[:id])
end

end

private

def set_category
  @category = Category.find(params[:id])

end
