class AddRegistrationRefToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :registration, foreign_key: true
  end
end
