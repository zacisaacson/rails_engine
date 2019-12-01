require 'rails_helper'

describe "Items API" do
  it "can index a list of items" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create(:item, merchant_id: merchant_1.id)
    create(:item, merchant_id: merchant_2.id)
    create(:item, merchant_id: merchant_1.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
  end

  it "can show an item by its id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(id.to_s)
  end
end
