class Comment < ApplicationRecord
  belongs_to :entry
  validates :body, presence: {message: 'não pode ficar em branco'}
end
