class ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      params[:images][:image].each do |image|
        @item.images.create(image: image)
      end
      redirect_to root_path
    else
      render "sells/sell"
    end
  end

  def show
    @item = Item.find(params[:id])
    @address = Address.find_by(user_id: @item.user_id)
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def search
    # like句によるあいまい検索
    @items = Item.where('item LIKE(?)', "%#{params[:keyword]}%").order("id DESC")
    if params[:keyword] == ""
      redirect_to '/items/search?utf8=✓&keyword=+++'
    end
    if @items.count == 0
      @all_items = Item.limit(5).order("id DESC")
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :price,
      :category_id,
      :brands_category_id,
      :shopping_status,
      :size_id,
      :item_condition_id,
      image_attributes: [:image, :id]
      ).merge(user_id: current_user.id)
  end
end

