class AddDescriptionToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :description, :string
  end
end
