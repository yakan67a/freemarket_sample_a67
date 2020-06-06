class CategoriesController < ApplicationController

before_action :set_category, only: [:parent, :child, :grandchild]
before_action :set_parents, only: [:parent, :child, :grandchild]
def index
end


def parent
  children = @category.children
  grandchildren = []
  children.each do |child|
    grandchildren << Category.childrenTree("#{@category.id}/#{child.id}")
  end
  @items = []
  grandchildren.each do |grandchild|
    grandchild.each do |id|
      @items += Item.parentItems(id)
    end
  end
  @categories = Category.pickup_parents
end

def child
  grandchildren = @category.children
  @items = []
  grandchildren.each do |grandchild|
    @items += Item.childItems(grandchild)
  end
end

def grandchild
  @items = Item.grandchildItems(params[:id])
end


private

def set_category
  @category = Category.find(params[:id])
end

def set_parents
  @parents = Category.pickup_parents
end

end

