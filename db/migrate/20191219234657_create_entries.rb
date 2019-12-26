class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :vacancy, foreign_key: true
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
