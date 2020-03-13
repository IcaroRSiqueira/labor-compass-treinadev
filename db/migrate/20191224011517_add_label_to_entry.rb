class AddLabelToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :label, :integer, default: 0
  end
end
