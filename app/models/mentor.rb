class Mentor < ApplicationRecord
  belongs_to :school
  has_many :reports, dependent: :destroy
end
