class Vacancy < ApplicationRecord
  validates :title, :description, :skill, :wage, :role, :end_date, :location,
            presence: {message: 'não pode ficar em branco'}
end
