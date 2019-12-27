class Entry < ApplicationRecord
  belongs_to :vacancy
  belongs_to :candidate
  has_one :profile, through: :candidate
  has_one :proposal
  has_many :comments
  has_one :feedback
  enum label: {not_featured: 0, featured: 5}
  enum status: {avaiable: 0, rejected: 5}
end
