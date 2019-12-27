class AddStatusToProposal < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :status, :integer, defeault: 0
  end
end
