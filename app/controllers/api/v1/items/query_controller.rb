class Api::V1::Items::QueryController < ApplicationController
  def find
    render json: ItemSerializer.new(Item.find_by(item_params))
  end

  def find_all
    render json: ItemSerializer.new(Item.where(item_params).order('id ASC'))
  end

  def random
    render json: ItemSerializer.new((Item.all).sample)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
