class AddLabelToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :label, :integer, defeault: 0
  end
end
