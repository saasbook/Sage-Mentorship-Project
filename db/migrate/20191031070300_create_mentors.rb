class CreateMentors < ActiveRecord::Migration[5.2]
  def change
    create_table :mentors do |t|
      t.string :name
      t.integer :school_id
      t.string :email
      t.references :school, foreign_key: true

      t.timestamps
      t.index ["school_id"], name: "index_mentors_on_school_id"
    end
  end
end
