FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { 1.5 }
    status { "MyString" }
    frequency { 1 }
    customer { nil }
  end
end
