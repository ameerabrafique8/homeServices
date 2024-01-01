class Booking < ApplicationRecord
  belongs_to :customer, foreign_key: "user_id", class_name: "User"
  belongs_to :service

end
