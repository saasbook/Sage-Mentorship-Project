class School < ApplicationRecord
  has_one :admin, dependent: :destroy
  has_many :mentors, dependent: :destroy
  has_many :checkins, dependent: :destroy
  has_many :checkouts, dependent: :destroy

  validates :name, presence: true,  uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 100}
  validates :address, presence: true,  uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 300}
  validates :lat, presence: true
  validates :lon, presence: true

  # return the list of totalhours = {num_hours, forgot_checkout}
  # for all mentors in the specific week for the school
  # Assuming each mentor is associated with only one school, not many-to-many association

  def activities(week_date)
    result = []
    self.mentors.each do |mentor|
        totalhours = mentor.totalhours(week_date)
        if totalhours[:school_name] == self.name || totalhours[:school_name].nil?
          num_hours = totalhours[:num_hours]
          forgot_checkout = totalhours[:forgot_checkout]
          anyInvalid = totalhours[:anyInvalid]
          result.push({mentor:mentor, num_hours:num_hours, forgot_checkout: forgot_checkout, anyInvalid: anyInvalid})
        end
    end
    result
  end

end
