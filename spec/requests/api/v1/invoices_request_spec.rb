require 'rails_helper'

describe "Invoices API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_1.id)
    @invoice_4 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_2.id)
  end

  it "can index a list of invoices" do

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices['data'].count).to eq(4)
  end

  it "can show an invoice by its id" do

    get "/api/v1/invoices/#{@invoice_1.id}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['id']).to eq(@invoice_1.id.to_s)
  end

  it "can find an invoice by its customer id" do
  
    item = create(:item, merchant_id: @merchant.id)

    get "/api/v1/items/find?customer_id=#{item.name}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['name']).to eq(item.name)
  end

  xit "can find an item by its description" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?description=#{item.description}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['description']).to eq(item.description)
  end

  xit "can find an item by its unit_price" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['attributes']['unit_price']).to eq(item.unit_price.to_s)
  end

  xit "can find an item by its id" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  xit "can find a item by its creation date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC")

    get "/api/v1/items/find?created_at=#{item.created_at}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  xit "can find item by its updated date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    expect(response).to be_successful

    item_json = JSON.parse(response.body)

    expect(item_json['data']['id']).to eq(item.id.to_s)
  end

  xit "can find all items by parameter" do
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

  xit "can get random item" do
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
