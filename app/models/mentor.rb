class Mentor < ApplicationRecord
  
  belongs_to :school
  has_many :checkins, dependent: :destroy
  has_many :checkouts, dependent: :destroy

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 3, maximum: 60}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum: 320}, format: {with: VALID_EMAIL_REGEX}

  # return a list of attendences of the mentor in the specific week
  # where an attendence is a hash containing both the checkin and checkout

  def attendences(start_of_week)
     result = []
     end_of_week = start_of_week.end_of_week.utc
     self.checkins.each do |checkin|
        if checkin.checkin_time >= start_of_week && checkin.checkin_time <= end_of_week
            checkout = checkin.correspond_checkout
            result.push({checkin:checkin, checkout:checkout})
        end
     end
     result
  end


  # return the totalhours = {num_hours, forgot_checkout} for the mentor in the specific week
  # Assuming each mentor is associated with only one school.
  # Otherwise, many-to-many association would require an argument "school_id" to specify which school

  def totalhours(start_of_week)
    duration = 0
    forgot_checkout = false
    attends = self.attendences(start_of_week)
    attends.each do |attend|
        #if attend[:checkin].school == school_id
            checkin = attend[:checkin]
            checkout = attend[:checkout]
            if checkout.nil?
                forgot_checkout = true
            else
                duration += checkout.checkout_time - checkin.checkin_time
            end
        #end
    end
    {num_hours: (duration / 1.hour), forgot_checkout: forgot_checkout}
  end
end
