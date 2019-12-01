class Api::V1::Merchants::QueryController < ApplicationController
  def find
    render json: MerchantSerializer.new(Merchant.find_by(merchant_params))
  end

  def find_all
    render json: MerchantSerializer.new(Merchant.where(merchant_params))
  end

  def random
    render json: MerchantSerializer.new((Merchant.all).sample)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
