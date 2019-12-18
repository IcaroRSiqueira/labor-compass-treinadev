class AddCandidateRefToProfile < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :candidate, foreign_key: true
  end
end
