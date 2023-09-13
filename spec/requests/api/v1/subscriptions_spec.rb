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

    describe "DELETE /api/v1/subscriptions/:id" do
      it "deletes a subscription" do
        subscription = create(:subscription)
        
        delete "/api/v1/subscriptions/#{subscription.id}"

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to be_a(Hash)
        expect(data).to have_key(:message)
        expect(data[:message]).to eq("Subscription successfully deleted")
      end
    end

    describe "INDEX /api/v1/subscriptions" do
      it "returns all subscriptions" do
        list = create_list(:subscription, 3)

        get "/api/v1/subscriptions" 

        sub_data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        sub_data.map do |sub|
        expect(sub).to be_a(Hash)
        
        expect(sub).to have_key(:id)
        expect(sub[:id]).to be_a(Integer)

        expect(sub).to have_key(:title)
        expect(sub[:title]).to be_a(String)

        expect(sub).to have_key(:price)
        expect(sub[:price]).to be_a(Float)

        expect(sub).to have_key(:status)
        expect(sub[:status]).to be_a(String)

        expect(sub).to have_key(:frequency)
        expect(sub[:frequency]).to be_a(String)

        expect(sub).to have_key(:customer_id)
        expect(sub[:customer_id]).to be_an(Integer)

        expect(sub).to have_key(:tea_id)  
        expect(sub[:tea_id]).to be_an(Integer)

        expect(sub).to have_key(:created_at)
        expect(sub[:created_at]).to be_a(String)

        expect(sub).to have_key(:updated_at)
        expect(sub[:updated_at]).to be_a(String)

        expect(sub).to have_key(:deleted_at)
        expect(sub[:deleted_at]).to be_a(NilClass)
        end
      end

      it "return all subscriptions including deleted subscriptions" do
        subscription = create(:subscription)
        list = create_list(:subscription, 3)
        
        delete "/api/v1/subscriptions/#{subscription.id}"

        
        
        get "/api/v1/subscriptions" 
        subs = JSON.parse(response.body, symbolize_names: true)

        subs.map do |sub|

          expect(sub[:deleted_at]).to be_a_kind_of(String).or be_nil
          expect(subs[2][:deleted_at]).to be_a(NilClass)
          expect(subs[3][:deleted_at]).not_to be_nil
          expect(subs[3][:deleted_at]).to be_a(String)
        end
      end
    end
  end
end
