class HomeController < ApplicationController  
  def index
    @items = Item.reorder

  end
end
