require_relative 'modules/convertable'

class Item < ApplicationRecord
  include Convertable
  before_save :convert_to_currency

  validates_presence_of :name,
                        :description,
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

end
