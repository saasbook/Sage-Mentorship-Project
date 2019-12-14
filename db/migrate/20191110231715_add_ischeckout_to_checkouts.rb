class AddIscheckoutToCheckouts < ActiveRecord::Migration[5.2]
  def change
    add_column :checkouts, :ischeckout, :boolean
  end
end
