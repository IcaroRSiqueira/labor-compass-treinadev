class Proposal < ApplicationRecord
  belongs_to :candidate
  belongs_to :entry
  has_one :report
  enum status: {avaiable: 0, accepted: 5, refused: 10}
end
