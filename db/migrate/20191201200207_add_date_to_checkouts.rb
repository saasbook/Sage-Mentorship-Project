class AddDateToCheckouts < ActiveRecord::Migration[5.2]
  def change
  	add_column :checkouts, :date, :string
  end
end
