class Api::V1::Transactions::QueryController < ApplicationController
  def find
    render json: TransactionSerializer.new(Transaction.find_by(transaction_params))
  end

  def find_all
    render json: TransactionSerializer.new(Transaction.where(transaction_params).order('id ASC'))
  end

  def random
    render json: TransactionSerializer.new((Transaction.all).sample)
  end

  private

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
