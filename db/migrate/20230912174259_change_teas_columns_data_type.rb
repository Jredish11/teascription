class ChangeTeasColumnsDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :teas, :brew_time, :integer, using: 'brew_time::integer'
    change_column :teas, :temperature, :integer, using: 'temperature::integer'
  end
end
