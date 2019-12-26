class AddEntryRefToProposal < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :entry, foreign_key: true
  end
end
