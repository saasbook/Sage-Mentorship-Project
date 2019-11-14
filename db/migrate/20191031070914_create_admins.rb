class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.integer "school_id"
      t.references :school, foreign_key: true

      t.timestamps
      t.index ["school_id"], name: "index_admins_on_school_id"
    end
  end
end
