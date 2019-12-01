class Api::V1::Customers::QueryController < ApplicationController
  def find
    render json: CustomerSerializer.new(Customer.find_by(customer_params))
  end

  def find_all
    render json: CustomerSerializer.new(Customer.where(customer_params))
  end

  def random
    render json: CustomerSerializer.new((Customer.all).sample)
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
