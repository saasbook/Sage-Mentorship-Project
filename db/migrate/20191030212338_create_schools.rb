class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
