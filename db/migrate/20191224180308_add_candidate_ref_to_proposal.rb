class AddCandidateRefToProposal < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :candidate, foreign_key: true
  end
end
