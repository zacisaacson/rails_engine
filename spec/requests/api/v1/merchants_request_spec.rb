require 'rails_helper'

describe "Merchants API" do
  it "can index a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(3)
  end

  it "can show a merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq(id.to_s)
  end

  it "can find a merchant by its name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data']['attributes']['name']).to eq(merchant.name)
  end

  it "can find a merchant by its id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data']['id']).to eq(merchant.id.to_s)
  end

  it "can find a merchant by its creation date" do
    merchant = create(:merchant, created_at: "2019-11-20 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data']['id']).to eq(merchant.id.to_s)
  end

  it "can find merchant by its updated date" do
    merchant = create(:merchant, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data']['id']).to eq(merchant.id.to_s)
  end

  it "can find all merchants by parameter" do
    merchant_1 = create(:merchant, created_at: "2022-03-15 08:46:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    merchant_2 = create(:merchant, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")
    merchant_3 = create(:merchant, created_at: "2019-11-20 14:53:59 UTC", updated_at: "2019-11-23 10:43:10 UTC")

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data'].length).to eq(1)

    get "/api/v1/merchants/find_all?created_at=#{merchant_2.created_at}"

    expect(response).to be_successful

    merchant_json_1 = JSON.parse(response.body)

    expect(merchant_json_1['data'].length).to eq(2)

    get "/api/v1/merchants/find_all?updated_at=#{merchant_3.updated_at}"

    expect(response).to be_successful

    merchant_json_2 = JSON.parse(response.body)

    expect(merchant_json_2['data'].length).to eq(3)
  end

  it "can get random merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get '/api/v1/merchants/random'

    expect(response).to be_successful

    merchant_json = JSON.parse(response.body)

    expect(merchant_json['data']['attributes']['id']).to eq(merchant_1.id).or eq(merchant_2.id)
  end
end
