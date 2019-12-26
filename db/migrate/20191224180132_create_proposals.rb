class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.date :start_date
      t.string :workload
      t.string :benefits
      t.string :wage
      t.text :details

      t.timestamps
    end
  end
end
