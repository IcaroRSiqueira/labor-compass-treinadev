class AddHeadhunterRefToProposal < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :headhunter, foreign_key: true
  end
end
