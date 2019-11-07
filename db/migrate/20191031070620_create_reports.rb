class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :school_id
      t.string :checkin_time
      t.string :chekcout_time
      t.float :checkin_lat
      t.float :checkin_lon
      t.float :checkout_lat
      t.float :checkout_lon
      t.boolean :is_checkout
      t.belongs_to :mentor, index: true

      t.timestamps
    end
  end
end
