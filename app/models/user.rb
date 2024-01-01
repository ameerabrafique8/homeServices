class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :lockable
  attr_accessor :name

  has_many :services, dependent: :destroy
  has_many :bookings,   dependent: :destroy

  enum role: { seller: 0, customer: 1 }
  enum gender: { male: 0, female: 1, other: 2 }

  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :gender, inclusion: { in: ['male', 'female', 'other'], allow_blank: true }
  validates :role, inclusion: { in: ['seller', 'customer'], allow_blank: true }

  def account_locked?
    failed_attempts >= self.class.maximum_attempts && locked_at.present?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def initialize_dashboard_data
    {
      user: self,
      services: services,
      bookings: bookings
    }
  end
end
