class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.string :time
      t.string :lat
      t.string :lon
      t.references :mentor, foreign_key: true
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
