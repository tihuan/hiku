class ItemsController < ApplicationController
  before_action :merge_hiku_token

  # attr_accessor :params

  def index
    items = Item.all_items(params.merge({ token: hiku_token }))
    render json: items, status: 200
  end

  def create
    puts 'CREATE Params?'
    p params
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

  private
  def merge_hiku_token
    puts "MERGING PARAMS"
    p @params = params.merge({ token: hiku_token })
    puts "DONE"
  end
end
