class Feedback < ApplicationRecord
  belongs_to :entry
  validates :body, presence: true
end
