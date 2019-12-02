require 'rails_helper'

describe "Customer transactions page" do
  it "can return all transactions for certain customer" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, created_at: "2018-03-12 10:30:00 UTC", updated_at: "2019-11-25 05:29:00 UTC")
    invoice_4 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "failed")
    transaction_4 = create(:transaction, invoice_id: invoice_4.id, credit_card_number: "2093840139844590")

    get "/api/v1/customers/#{customer_1.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].length).to eq(3)
  end
end
