class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.datetime :checkin_time
      t.string :checkin_lat
      t.string :checkin_lon
      t.integer :mentor_id
      t.integer :school_id
      t.references :mentor, foreign_key: true
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
