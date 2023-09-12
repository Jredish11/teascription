FactoryBot.define do
  factory :subscription do
    customer
    tea
    title { Faker::Subscription.plan }
    price { Faker::Number.decimal(l_digits: 2) }
    status { Faker::Subscription.status }
    frequency { Faker::Subscription.subscription_term }
  end
end
