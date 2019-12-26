class Proposal < ApplicationRecord
  belongs_to :candidate
  belongs_to :registration
end
