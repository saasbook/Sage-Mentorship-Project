class AddDateToCheckins < ActiveRecord::Migration[5.2]
  def change
  	add_column :checkouts, :date
  end
end
