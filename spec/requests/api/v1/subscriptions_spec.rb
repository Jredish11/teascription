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
        require 'pry'; binding.pry
      end
    end
  end
end
