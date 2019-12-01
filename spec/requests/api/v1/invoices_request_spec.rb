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

end
