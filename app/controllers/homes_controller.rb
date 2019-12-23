class HomesController < ApplicationController


  def index
    @item_all      = Item.all.order("created_at DESC").limit(10)
  end

  def show
    
  end
end
