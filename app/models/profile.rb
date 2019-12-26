class Profile < ApplicationRecord
  belongs_to :candidate
  has_many :entries, through: :candidate
  has_one_attached :avatar
end
