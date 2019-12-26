class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: {incomplete: 0, complete: 5}

  has_one :profile
  has_many :registrations
  has_many :proposals
  has_many :vacancies, through: :registrations

end
