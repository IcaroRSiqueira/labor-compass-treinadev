class CreateVacancies < ActiveRecord::Migration[6.0]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :description
      t.string :skill
      t.string :wage
      t.string :role
      t.date :end_date
      t.string :location

      t.timestamps
    end
  end
end
