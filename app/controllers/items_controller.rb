require 'pry'
class ItemsController < ApplicationController

  def index
    items = Item.all_items
    render json: items
  end

  def destroy
    render Item.destroy_items(params[:id])
  end
end
