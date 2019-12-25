class MypagesController < ApplicationController
  

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @items = user.items
  end

  def list
    user = User.find(params[:id])
    @nickname = user.nickname
    @items = user.items
  end
  def edit
  end

  def credit
  end

  def identification
  end

  def logout
  end

  def profile
  end

end
