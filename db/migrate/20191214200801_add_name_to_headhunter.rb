class AddNameToHeadhunter < ActiveRecord::Migration[6.0]
  def change
    add_column :headhunters, :name, :string
  end
end
