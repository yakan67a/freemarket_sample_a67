class ItemsController < ApplicationController

  # 出品した商品一覧表示用
  def index
    @items = Item.where(user_id: current_user.id).order('created_at DESC')
  end
    
  def new
    @item = Item.new
    @item.item_images.new
    @category_parent_array = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  # 出品商品編集用
  def edit
    @item = Item.find(params[:id])
    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = Category.where(ancestry: nil)

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end

  end

  # 編集した商品更新用
  def update
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  private
  def item_params
    params.require(:item).permit(:items_name,
        :item_description,
        :condition,
        :shipping_costs,
        :days_to_ship,
        :price,
        :category_id,
        :brand_id,
        :shipping_area_id,
        item_images_attributes: [:image_URL,:_destroy, :id]).merge(user_id: current_user.id)
  end
end
