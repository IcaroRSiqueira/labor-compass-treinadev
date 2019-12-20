class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.references :vacancy, foreign_key: true
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
