class AddRegistrationRefToProposal < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :registration, foreign_key: true
  end
end
