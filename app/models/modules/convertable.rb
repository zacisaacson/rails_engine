module Convertable
  def convert_to_currency
    self.unit_price = (self.unit_price.to_f / 100)
  end
end
