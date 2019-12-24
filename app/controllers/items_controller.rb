class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :destroy]

  def index
    #category_idの値は実際のメルカリ準拠。投稿時間を降順で最大10個表示させる。
    @ladys_items   = Item.where(category_id: 1).order("created_at DESC").limit(10)
    @mans_items    = Item.where(category_id: 2).order("created_at DESC").limit(10)
    @kaden_items   = Item.where(category_id: 8).order("created_at DESC").limit(10)
    @toy_items     = Item.where(category_id: 6).order("created_at DESC").limit(10)


  #例として、下記記述で各アイテムのタイトル、値段、画像(1枚目のみ)を取得することが可能(classは省略)
  #今後ビューファイルに反映させる際の参考コードとして下記記述を残す。
  # %h2 レディース新着アイテム
  # - @ladys_items.each do |lady|
  #   = lady.item
  #   = lady.price
  #   %img{src: "#{lady.images.first.image}", width:"300", height:"300"}
  end
  
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
      # render 'items#new'
      redirect_to new_item_path
    end
  end

  def show
    @address = Address.find_by(user_id: @item.user_id)
  end

  def destroy
    if @item.destroy
      redirect_to mypage_path(current_user)
    else
      redirect_to edit_item_path(params[:id])
    end
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

  def set_item
    @item = Item.find(params[:id])
  end

end

