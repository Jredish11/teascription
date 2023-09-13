class AddDeletedAtToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :deleted_at, :datetime, default: nil
    add_index :subscriptions, :deleted_at
  end
end
