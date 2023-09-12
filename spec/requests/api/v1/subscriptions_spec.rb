require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  describe "Subscription API" do
    let!(:customer) {create(:customer)}
    let!(:tea) {create(:tea)}
    
    describe "POST /api/v1/subscriptions" do
      it "creates a new subscription" do
        attrs = {
          title: "Earl Grey",
          price: 5.00,
          status: "active",
          frequency: "monthly",
          customer_id: customer.id,
          tea_id: tea.id
        }

        post "/api/v1/subscriptions", params: { subscription: attrs }
        sub_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(sub_data).to be_a(Hash)
        expect(sub_data).to have_key(:data)

        expect(sub_data[:data]).to be_a(Hash)
        
        expect(sub_data[:data]).to have_key(:id)
        expect(sub_data[:data][:id]).to be_a(String)
  
        expect(sub_data[:data]).to have_key(:type)
        expect(sub_data[:data][:type]).to be_a(String)

        expect(sub_data[:data]).to have_key(:attributes)
        expect(sub_data[:data][:attributes]).to be_a(Hash)

        expect(sub_data[:data][:attributes]).to have_key(:id)
        expect(sub_data[:data][:attributes][:id]).to be_an(Integer)

        expect(sub_data[:data][:attributes]).to have_key(:title)
        expect(sub_data[:data][:attributes][:title]).to be_a(String)

        expect(sub_data[:data][:attributes]).to have_key(:price)
        expect(sub_data[:data][:attributes][:price]).to be_a(Float)

        expect(sub_data[:data][:attributes]).to have_key(:status)
        expect(sub_data[:data][:attributes][:status]).to be_a(String)

        expect(sub_data[:data][:attributes]).to have_key(:frequency)
        expect(sub_data[:data][:attributes][:frequency]).to be_a(String)

        expect(sub_data[:data][:attributes]).to have_key(:customer_id)
        expect(sub_data[:data][:attributes][:customer_id]).to be_an(Integer)

        expect(sub_data[:data][:attributes]).to have_key(:tea_id)
        expect(sub_data[:data][:attributes][:tea_id]).to be_an(Integer)
      end
    end
    
    describe "sad path" do
      it 'returns 422 with invalid attributes if customer and/or tea does not exist' do
        invalid_attrs = {
          title: 'Earl Grey',
          price: 29.99,
          status: 'active',
          frequency: 'monthly',
          
        }
        post '/api/v1/subscriptions', params: { subscription: invalid_attrs }
        expect(response).to_not be_successful
        expect(response.status).to eq(422)
      end
    end
  end
end
