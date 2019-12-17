class ItemsController < ApplicationController
  def index
    
  end

  def show
    
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
