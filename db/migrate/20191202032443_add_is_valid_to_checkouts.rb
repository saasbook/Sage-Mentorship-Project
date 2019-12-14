class AddIsValidToCheckouts < ActiveRecord::Migration[5.2]
  def change
    add_column :checkouts, :isValid, :boolean
  end
end
