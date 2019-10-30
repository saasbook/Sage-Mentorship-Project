class CreateMentors < ActiveRecord::Migration[5.2]
  def change
    create_table :mentors do |t|
      t.string :name
      t.string :email
      t.references :school, foreign_key: true

      t.timestamps
    end
  end
end
