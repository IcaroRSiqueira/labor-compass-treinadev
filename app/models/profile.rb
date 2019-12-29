class Profile < ApplicationRecord
  belongs_to :candidate
  has_many :entries, through: :candidate
  has_one_attached :avatar
  validates :full_name, :social_name, :birth_date, :education, :description,
            :experience, presence: {message: 'não pode ficar em branco'}
end
