class AddEntryRefToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :feedbacks, :entry, foreign_key: true
  end
end
