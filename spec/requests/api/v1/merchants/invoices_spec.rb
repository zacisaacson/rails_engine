require 'rails_helper'

describe "Merchant invoices page" do
  it "can show a merchants invoices" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id, created_at: "2018-03-12 10:30:00 UTC", updated_at: "2019-11-25 05:29:00 UTC")

    get "/api/v1/merchants/#{merchant_1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].length).to eq(2)
  end
end
