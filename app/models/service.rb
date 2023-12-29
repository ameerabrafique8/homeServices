class Service < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  has_many :bookings

  validates :name, :description, presence: true
  enum status: { pending: 0, approved: 1, rejected: 2, in_progress: 3, completed: 4, canceled: 5 }
end
