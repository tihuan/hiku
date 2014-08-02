class ItemsController < ApplicationController

  def index
    items = Item.all_items
    render json: items, status: 200
  end

  def create
    if item_created = Item.create_item(params)
      render json: item_created, status: 200
    else
      render json: 'Something went wrong. Please try again!'
    end
  end

  def destroy
    if item_destroyed = Item.destroy_items(params)
      render json: item_destroyed, status: 200
    else
      render json: 'Something went wrong. Please try again!'
    end
  end
end
