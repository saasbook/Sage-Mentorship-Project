class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.datetime :checkin_time
      t.decimal :latitude
      t.decimal :longitude
      t.references :mentor, foreign_key: true
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
