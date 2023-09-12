class ChangeFrequencyDataTypeInSubscriptions < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :frequency, :string
  end
end
