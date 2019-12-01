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

  it "can find a item by its name" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?name=#{item.name}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['name']).to eq(item.name)
  end

  it "can find an item by its description" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['description']).to eq(item.description)
  end

  it "can find an item by its unit_price" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['unit_price']).to eq(item.unit_price.to_s)
  end

  it "can find an item by its id" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  it "can find a item by its creation date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC")

    get "/api/v1/items/find?created_at=#{item.created_at}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  it "can find item by its updated date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  it "can find all items by parameter" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, created_at: "2022-03-15 08:46:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    item_2 = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    item_3 = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/items/find_all?id=#{item_1.id}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data'].length).to eq(1)

    get "/api/v1/items/find_all?created_at=#{item_2.created_at}"

    expect(response).to be_successful

    item_json_1 = JSON.parse(response.body)

    expect(item_json_1['data'].length).to eq(2)

    get "/api/v1/items/find_all?updated_at=#{item_3.updated_at}"

    expect(response).to be_successful

    item_json_2 = JSON.parse(response.body)

    expect(item_json_2['data'].length).to eq(3)
  end

  it "can get random item" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)

    get '/api/v1/items/random'

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['id']).to eq(item_1.id).or eq(item_2.id)
  end
end
