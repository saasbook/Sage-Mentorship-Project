class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.datetime :checkout_time
      t.string :lat
      t.string :lon
      t.integer :mentor_id
      t.integer :school_id
      t.references :mentor, foreign_key: true
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
