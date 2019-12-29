class Vacancy < ApplicationRecord
  validates :title, :description, :skill, :wage, :role, :end_date, :location,
            presence: {message: 'não pode ficar em branco'}
  belongs_to :headhunter
  has_many :entries
  has_many :candidates, through: :registrations
  enum status: {avaiable: 0, finalized: 5}
  enum visibility: {visible: 0, invisible: 5}

end
