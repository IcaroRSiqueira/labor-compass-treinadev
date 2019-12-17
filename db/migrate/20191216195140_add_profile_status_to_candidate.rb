class AddProfileStatusToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :status, :integer, defeault: 0
  end
end
