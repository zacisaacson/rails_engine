class Api::V1::Invoices::QueryController < ApplicationController
  def find
    render json: InvoiceSerializer.new(Invoice.find_by(invoice_params))
  end

  def find_all
    render json: InvoiceSerializer.new(Invoice.where(invoice_params).order('id ASC'))
  end

  def random
    render json: InvoiceSerializer.new((Invoice.all).sample)
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
