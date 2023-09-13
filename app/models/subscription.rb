class Subscription < ApplicationRecord
  acts_as_paranoid column: :deleted_at
  belongs_to :customer
  belongs_to :tea
end
