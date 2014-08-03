class ItemsController < ApplicationController

  def index
    items = Item.all_items(merge_hiku_token(params))
    render json: items, status: 200
  end

  def create
    item_created = Item.create_item(merge_hiku_token(params))
    if item_created[:status] == "ok"
      render json: item_created, status: 200
    else
      #  TODO: Implement after create msg
      render json: 'Something went wrong. Please try again!', status: 503
    end
  end

  def destroy
    if item_destroyed = Item.destroy_items(merge_hiku_token(params))
      render json: item_destroyed, status: 200
    else
      render json: 'Something went wrong. Please try again!'
    end
  end

  private
  def merge_hiku_token(params)
    params.merge({ token: hiku_token })
  end
end
