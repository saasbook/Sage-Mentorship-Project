class School < ApplicationRecord
#  has_one :admin
  has_many :admins
  has_many :mentors
  has_many :checkins

  validates :name, presence: true,  uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 100}
  validates :address, presence: true,  uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 300}
  validates :lat, presence: true
  validates :lon, presence: true

  # return the list of totalhours = {num_hours, forgot_checkout}
  # for all mentors in the specific week for the school
  # Assuming each mentor is associated with only one school, not many-to-many association

  def totalhours_list(start_of_week)
    result = []
    self.mentors.each do |mentor|
        totalhours = mentor.totalhours(start_of_week)
        num_hours = totalhours[:num_hours]
        forgot_checkout = totalhours[:forgot_checkout]
        result.push({mentor:mentor, num_hours:num_hours, forgot_checkout: forgot_checkout})
    end
    result
  end

end
