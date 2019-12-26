class AddStatusToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :status, :integer, defeault: 0
  end
end
