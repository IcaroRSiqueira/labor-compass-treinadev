class AddStatusToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :status, :integer, default: 0
  end
end
