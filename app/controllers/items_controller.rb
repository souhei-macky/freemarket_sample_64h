class ItemsController < ApplicationController

  def index
    #category_idの値は実際のメルカリ準拠。投稿時間を降順で最大10個表示させる。
    @ladys_items   = Item.where(category_id: 1).order("created_at DESC").limit(10)
    @mans_items    = Item.where(category_id: 2).order("created_at DESC").limit(10)
    @kaden_items   = Item.where(category_id: 7).order("created_at DESC").limit(10)
    @toy_items     = Item.where(category_id: 1328).order("created_at DESC").limit(10)
    @chanel_items  = Item.where(brand_id: 658).order("created_at DESC").limit(10)
    @vuitton_items = Item.where(brand_id: 857).order("created_at DESC").limit(10)
    @supreme_items = Item.where(brand_id: 1620).order("created_at DESC").limit(10)
    @nike_items    = Item.where(brand_id: 857).order("created_at DESC").limit(10)

  #例として、下記記述で各アイテムのタイトル、値段、画像(1枚目のみ)を取得することが可能(classは省略)
  #今後ビューファイルに反映させる際の参考コードとして下記記述を残す。
  # %h2 レディース新着アイテム
  # - @ladys_items.each do |lady|
  #   = lady.item
  #   = lady.price
  #   %img{src: "#{lady.images.first.image}", width:"300", height:"300"}
  end

  def create
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

end

