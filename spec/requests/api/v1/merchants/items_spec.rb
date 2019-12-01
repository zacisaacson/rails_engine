require 'rails_helper'

describe "Merchant items page" do
  it "can show a merchants items" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create(:item, merchant_id: merchant_1.id)
    create(:item, merchant_id: merchant_2.id)
    create(:item, merchant_id: merchant_1.id)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].length).to eq(2)
  end
end
