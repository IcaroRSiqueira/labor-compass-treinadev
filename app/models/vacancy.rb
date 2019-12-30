class Vacancy < ApplicationRecord
  validates :title, :description, :skill, :wage, :role, :end_date, :location,
            presence: {message: 'não pode ficar em branco'}
  validate :end_date_must_be_greater_than_today
  belongs_to :headhunter
  has_many :entries
  has_many :candidates, through: :registrations
  enum status: {avaiable: 0, finalized: 5}

  def end_date_must_be_greater_than_today
    if end_date <= Date.current
      errors.add(:end_date, 'deve ser maior que data de fim')
    end
  end
end
