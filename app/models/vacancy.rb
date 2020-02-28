class Vacancy < ApplicationRecord
  validates :title, :description, :skill, :wage, :role, :end_date, :location,
            presence: true
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

#  after_commit do
#  delay(run_at: end_date + 1.day).expire!
#  end
#  def expire!
#    finalized! unless finalized?
#  end
end
