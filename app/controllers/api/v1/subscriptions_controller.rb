class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create!(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 200
    else
      render json: { error: subscription.errors.messages }, status: 422
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end
