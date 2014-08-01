require 'pry'
class ItemsController < ApplicationController

  def index
    items = Item.all_items
    render json: items
  end
end
