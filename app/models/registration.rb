class Registration < ApplicationRecord
  belongs_to :vacancy
  belongs_to :candidate
  has_one :profile, through: :candidate
  has_many :comments
end
