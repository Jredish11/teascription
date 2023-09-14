class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :price, :frequency, :customer_id, :tea_id, :deleted_at
end
