require_relative 'modules/convertable'

class InvoiceItem < ApplicationRecord
  include Convertable
  before_save :convert_to_currency

  validates_presence_of :quantity,
                        :unit_price

  belongs_to :item
  belongs_to :invoice

end
