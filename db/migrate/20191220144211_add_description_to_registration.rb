class AddDescriptionToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :description, :string
  end
end
