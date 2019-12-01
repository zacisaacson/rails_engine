FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "8402840348392098" }
    credit_card_expiration_date { "MyString" }
    result { "success" }
  end
end
