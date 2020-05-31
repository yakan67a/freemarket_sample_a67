class ItemsController < ApplicationController

  before_action :move_to_login
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :item_purchased?, only: [:edit, :update, :destroy]

  # 出品した商品一覧表示用
  def index
    @items = current_user.items.order('created_at DESC')
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

  def show
    @category = @item.category
  end

  # 出品商品編集用
  def edit
    if @item.user_id != current_user.id
      redirect_to root_path
    end

    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = Category.where(ancestry: nil)
    @category_children_array =  Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)

  end

  # 編集した商品更新用
  def update
    if params[:item].keys.include?("item_image") || params[:item].keys.include?("item_images_attributes") 
      if @item.valid?
        if params[:item].keys.include?("item_image") 
          update_images_ids = params[:item][:item_image].values
          before_images_ids = @item.item_images.ids
          before_images_ids.each do |before_img_id|
            ItemImage.find(before_img_id).destroy unless update_images_ids.include?("#{before_img_id}") 
          end
        else
          before_images_ids = @item.item_images.ids
          before_images_ids.each do |before_img_id|
            ItemImage.find(before_img_id).destroy 
          end
        end
        @item.update(item_params)
        redirect_to update_complete_user_path(current_user.id), notice: "商品を更新しました"
      else
        flash.now[:error] = '更新失敗'
        render 'users/update_complete' 
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # 商品削除用
  def destroy
    if @item.user.id == current_user.id
      if @item.destroy
        redirect_to update_complete_user_path(current_user.id), notice: "商品を削除しました"
      else
        redirect_to update_complete_user_path(current_user.id), alert: '削除に失敗しました'
      end
    else
      flash.now[:error] = '削除できません'
      render 'users/update_complete'
    end
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
        :prefecture_id,
        item_images_attributes: [:image_URL, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def item_purchased?
    if @item.history.present?
      flash.now[:error] = '購入済みの商品の編集/削除はできません'
      render 'users/update_complete' 
    end
  end

end
