class Api::V1::InvoiceItems::QueryController < ApplicationController
  def find
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
  end

  def find_all
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params).order('id ASC'))
  end

  def random
    render json: InvoiceItemSerializer.new((InvoiceItem.all).sample)
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
