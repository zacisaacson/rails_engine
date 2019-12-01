FactoryBot.define do
  factory :item do
    name { "The best" }
    description { "The best item ever" }
    unit_price { 1.5 }
    merchant { nil }
  end
end
