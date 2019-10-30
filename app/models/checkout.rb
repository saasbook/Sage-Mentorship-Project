class Checkout < ApplicationRecord
  belongs_to :mentor
  belongs_to :school

  validates :checkout_time, presence: true
end
