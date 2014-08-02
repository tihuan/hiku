require 'pry'
class ItemsController < ApplicationController

  def index
    items = Item.all_items
    render json: items, status: 200
  end

  def destroy
    render  json: Item.destroy_items(params[:id]), status: 200
  end
end
