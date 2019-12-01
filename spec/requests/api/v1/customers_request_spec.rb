require 'rails_helper'

describe "Customers API" do
  it "can index a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers['data'].count).to eq(3)
  end

  it "can show a customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer['data']['id']).to eq(id.to_s)
  end

  it "can find a customer by its first name" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['attributes']['first_name']).to eq(customer.first_name)
  end

  it "can find a customer by its last name" do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['attributes']['last_name']).to eq(customer.last_name)
  end

  it "can find a customer by its id" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['id']).to eq(customer.id.to_s)
  end

  it "can find a customer by its creation date" do
    customer = create(:customer, created_at: "2019-11-20 14:53:59 UTC")

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['id']).to eq(customer.id.to_s)
  end

  it "can find customer by its updated date" do
    customer = create(:customer, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['id']).to eq(customer.id.to_s)
  end

  it "can find all customers by parameter" do
    customer_1 = create(:customer, created_at: "2022-03-15 08:46:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    customer_2 = create(:customer, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    customer_3 = create(:customer, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data'].length).to eq(1)

    get "/api/v1/customers/find_all?created_at=#{customer_2.created_at}"

    expect(response).to be_successful

    customer_json_1 = JSON.parse(response.body)

    expect(customer_json_1['data'].length).to eq(2)

    get "/api/v1/customers/find_all?updated_at=#{customer_3.updated_at}"

    expect(response).to be_successful

    customer_json_2 = JSON.parse(response.body)

    expect(customer_json_2['data'].length).to eq(3)
  end

  it "can get random customer" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get '/api/v1/customers/random'

    expect(response).to be_successful

    customer_json = JSON.parse(response.body)

    expect(customer_json['data']['attributes']['id']).to eq(customer_1.id).or eq(customer_2.id)
  end
end
