class AddRegistrationRefToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :feedbacks, :registration, foreign_key: true
  end
end
