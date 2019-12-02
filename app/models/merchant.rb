class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue").
    joins(:invoice_items, :transactions).
    group(:id).
    # merge(Transaction.successful).
    order('revenue DESC').
    limit(quantity)
  end
end
