class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.string :education
      t.string :description
      t.string :experience

      t.timestamps
    end
  end
end
