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
end
