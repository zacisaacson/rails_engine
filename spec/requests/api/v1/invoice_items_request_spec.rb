require 'rails_helper'

describe "Invoice_Items API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_2.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    @invoice_3 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_1.id, created_at: "2018-03-12 10:30:00 UTC", updated_at: "2019-11-25 05:29:00 UTC")
    @invoice_4 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    @invoice_item_1 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, unit_price: 1892)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 4)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 4)
  end

  it "can index a list of invoice items" do

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items['data'].count).to eq(4)
  end

  it "can show an invoice item by its id" do

    get "/api/v1/invoice_items/#{@invoice_item_1.id}"

    expect(response).to be_successful

    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json['data']['attributes']['id']).to eq(@invoice_item_1.id)
  end

  it "can find a invoice item by its item id" do

    get "/api/v1/invoice_items/find?item_id=#{@item_3.id}"

    expect(response).to be_successful

    invoice_items_json = JSON.parse(response.body)

    expect(invoice_items_json['data']['attributes']['id']).to eq(@invoice_item_3.id)
  end

  it "can find an invoice item by its invoice id" do

    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_2.id}"

    expect(response).to be_successful

    invoice_items_json = JSON.parse(response.body)

    expect(invoice_items_json['data']['attributes']['id']).to eq(@invoice_item_2.id)
  end

  it "can find an invoice item by its quantity" do

    get "/api/v1/invoice_items/find?quantity=#{@invoice_item_3.quantity}"

    expect(response).to be_successful

    invoice_items_json = JSON.parse(response.body)

    expect(invoice_items_json['data']['attributes']['id']).to eq(@invoice_item_3.id)
  end

  it "can find an invoice item by its unit_price" do

    get "/api/v1/invoice_items/find?unit_price=#{@invoice_item_1.unit_price}"

    expect(response).to be_successful

    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json['data']['attributes']['id']).to eq(@invoice_item_1.id)
  end

  it "can find all invoice items by parameter" do

    get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"

    expect(response).to be_successful

    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json['data'].length).to eq(1)

    get "/api/v1/invoice_items/find_all?item_id=#{@item_2.id}"

    expect(response).to be_successful

    invoice_item_json_1 = JSON.parse(response.body)

    expect(invoice_item_json_1['data'].length).to eq(2)

    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_2.id}"

    expect(response).to be_successful

    invoice_item_json_2 = JSON.parse(response.body)

    expect(invoice_item_json_2['data'].length).to eq(1)

    get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_4.quantity}"

    expect(response).to be_successful

    invoice_item_json_3 = JSON.parse(response.body)

    expect(invoice_item_json_3['data'].length).to eq(2)
  end

  it "can get random invoice item" do

    get '/api/v1/invoice_items/random'

    expect(response).to be_successful

    invoice_item_json = JSON.parse(response.body)

    expect(invoice_item_json['data']['attributes']['id']).to eq(@invoice_item_1.id).or eq(@invoice_item_2.id).or eq(@invoice_item_3.id).or eq(@invoice_item_4.id)
  end
end
