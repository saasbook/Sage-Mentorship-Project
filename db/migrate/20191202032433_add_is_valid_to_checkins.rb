class AddIsValidToCheckins < ActiveRecord::Migration[5.2]
  def change
    add_column :checkins, :isValid, :boolean
  end
end
