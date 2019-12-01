require 'rails_helper'

describe "Transactions API" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, merchant_id: @merchant_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_1.id)
    @invoice_4 = create(:invoice, customer_id: @customer_2.id, merchant_id: @merchant_2.id)
    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id)
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: "failed")
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, credit_card_number: "2093840139844590")
  end

  it "can index a list of transactions" do

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions['data'].count).to eq(4)
  end

  it "can show a transaction by its id" do

    get "/api/v1/transactions/#{@transaction_1.id}"

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data']['attributes']['id']).to eq(@transaction_1.id)
  end

  it "can find a transaction by its invoice id" do

    get "/api/v1/transactions/find?invoice_id=#{@invoice_1.id}"

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data']['attributes']['id']).to eq(@transaction_1.id)
  end

  it "can find a transaction by its credit_card_number" do

    get "/api/v1/transactions/find?credit_card_number=#{@transaction_4.credit_card_number}"

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data']['attributes']['id']).to eq(@transaction_4.id)
  end

  it "can find a transaction by its result" do

    get "/api/v1/transactions/find?result=#{@transaction_3.result}"

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data']['attributes']['id']).to eq(@transaction_3.id)
  end

  it "can find all transactions by parameter" do

    get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data'].length).to eq(1)

    get "/api/v1/transactions/find_all?invoice_id=#{@invoice_1.id}"

    expect(response).to be_successful

    transaction_json_1 = JSON.parse(response.body)

    expect(transaction_json_1['data'].length).to eq(2)

    get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_4.credit_card_number}"

    expect(response).to be_successful

    transaction_json_2 = JSON.parse(response.body)

    expect(transaction_json_2['data'].length).to eq(1)

    get "/api/v1/transactions/find_all?result=#{@transaction_4.result}"

    expect(response).to be_successful

    transaction_json_3 = JSON.parse(response.body)

    expect(transaction_json_3['data'].length).to eq(3)
  end

  it "can get random transcation" do

    get '/api/v1/transactions/random'

    expect(response).to be_successful

    transaction_json = JSON.parse(response.body)

    expect(transaction_json['data']['attributes']['id']).to eq(@transaction_1.id).or eq(@transaction_2.id).or eq(@transaction_3.id).or eq(@transaction_4.id)
  end
end
