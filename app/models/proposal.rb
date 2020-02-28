class Proposal < ApplicationRecord
  belongs_to :candidate
  belongs_to :entry
  belongs_to :headhunter
  has_one :report
  enum status: {avaiable: 0, accepted: 5, refused: 10}
  validates :start_date, :workload, :benefits, :wage, :details, presence: true
end
