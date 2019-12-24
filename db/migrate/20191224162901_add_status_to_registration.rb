class AddStatusToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :status, :integer, defeault: 0
  end
end
