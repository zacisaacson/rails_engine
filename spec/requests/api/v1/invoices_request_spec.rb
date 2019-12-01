require 'rails_helper'

describe "Invoices API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
    @invoice_3 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_1.id, created_at: "2018-03-12 10:30:00 UTC", updated_at: "2019-11-25 05:29:00 UTC")
    @invoice_4 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_2.id, created_at: "2019-11-20 14:53:59 UTC")
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

    get "/api/v1/invoices/find?customer_id=#{@customer_1.id}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['customer_id']).to eq(@customer_1.id)
  end

  it "can find an invoice by its merchant id" do

    get "/api/v1/invoices/find?merchant_id=#{@merchant_1.id}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['merchant_id']).to eq(@merchant_1.id)
  end

  it "can find an invoice by its status" do

    get "/api/v1/invoices/find?status=#{@invoice_1.status}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['status']).to eq("shipped")
  end

  it "can find an invoice by its creation date" do

    get "/api/v1/invoices/find?created_at=#{@invoice_3.created_at}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['id']).to eq(@invoice_3.id)
  end

  it "can find invoice by its updated date" do

    get "/api/v1/invoices/find?updated_at=#{@invoice_3.updated_at}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['id']).to eq(@invoice_3.id)
  end

  it "can find all invoices by parameter" do

    get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data'].length).to eq(1)

    get "/api/v1/invoices/find_all?customer_id=#{@customer_2.id}"

    expect(response).to be_successful

    invoice_json_1 = JSON.parse(response.body)
    
    expect(invoice_json_1['data'].length).to eq(2)

    get "/api/v1/invoices/find_all?merchant_id=#{@merchant_2.id}"

    expect(response).to be_successful

    invoice_json_2 = JSON.parse(response.body)

    expect(invoice_json_2['data'].length).to eq(2)

    get "/api/v1/invoices/find_all?status=#{@invoice_4.status}"

    expect(response).to be_successful

    invoice_json_3 = JSON.parse(response.body)

    expect(invoice_json_3['data'].length).to eq(4)

    get "/api/v1/invoices/find_all?created_at=#{@invoice_4.created_at}"

    expect(response).to be_successful

    invoice_json_4 = JSON.parse(response.body)

    expect(invoice_json_4['data'].length).to eq(2)

    get "/api/v1/invoices/find_all?updated_at=#{@invoice_3.updated_at}"

    expect(response).to be_successful

    invoice_json_5 = JSON.parse(response.body)

    expect(invoice_json_5['data'].length).to eq(1)
  end

  it "can get random invoice" do

    get '/api/v1/invoices/random'

    expect(response).to be_successful

    invoice_json = JSON.parse(response.body)

    expect(invoice_json['data']['attributes']['id']).to eq(@invoice_1.id).or eq(@invoice_2.id).or eq(@invoice_3.id).or eq(@invoice_4.id)
  end
end
