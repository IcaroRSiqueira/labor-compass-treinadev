class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.text :body
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end
