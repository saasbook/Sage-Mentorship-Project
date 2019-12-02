class AddDateToCheckins < ActiveRecord::Migration[5.2]
  def change
  	add_column :checkins, :date, :string
  end
end
