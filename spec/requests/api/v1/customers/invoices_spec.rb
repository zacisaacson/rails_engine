require 'rails_helper'

describe "Customer invoices page" do
  it "can return all invoices for certain customer" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_1.id)
    item_3 = create(:item, merchant_id: merchant_2.id)
    item_4 = create(:item, merchant_id: merchant_2.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id, created_at: "2018-03-12 10:30:00 UTC", updated_at: "2019-11-25 05:29:00 UTC")
    invoice_4 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")

    get "/api/v1/customers/#{customer_1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].length).to eq(2)
  end
end
