
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
  # where an attendence is a hash containing
  # {school_name, date, duration, forgot_checkout, isValid, checkin, checkout}

  def attendances(week_date)
     result = []
     self.checkins.each do |checkin|
        checkin_time = checkin.checkin_time
        if same_week?(checkin_time, week_date)
            date = checkin_time.strftime("%m/%d/%Y")
            school_name = checkin.school.name
            checkout = checkin.correspond_checkout
            forgot_checkout = checkout.nil?
            isValid = checkin.isValid && (checkout.nil? ? true : checkout.isValid)
            duration = duration_length(checkin, checkout)
            result.push({school_name:school_name,
                        date:date, duration:duration,
                        forgot_checkout: forgot_checkout,
                        isValid: isValid,
                        checkin:checkin, checkout:checkout})
        end
     end
     result
  end

  # return whether timeA and timeB are in the same week
  def same_week?(timeA, timeB)
    if timeA >= timeB.beginning_of_week && timeA <= timeB.end_of_week
      true
    else
      false
    end
  end

  # return the duration between a checkin and a checkout in hours
  def duration_length(checkin, checkout)
    duration = 0
    unless checkout.nil?
        duration = (checkout.checkout_time - checkin.checkin_time) / 1.hour
        duration = duration.round(2)
    end
    duration
  end

  # return the totalhours = {week_date, school_name, num_hours, forgot_checkout, anyInvalid}
  # for the mentor in the specific week
  # Assuming each mentor is associated with only one school.
  # Otherwise, many-to-many association would require an argument "school_id" to specify which school
  # Assuming the mentor only check in at one school in a week, even though mentors can be reassigned to different school

  def totalhours(week_date)
    num_hours = 0
    school_name = nil
    forgot_checkout = false
    anyInvalid = false
    self.attendances(week_date).each do |attend|
        school_name = attend[:school_name]
        num_hours += attend[:duration]
        forgot_checkout = true if attend[:forgot_checkout]
        anyInvalid = true unless attend[:isValid]
    end
    week_date = week_date.beginning_of_week.strftime("%m/%d/%Y")
    {week_date: week_date,
      school_name: school_name,
      num_hours: num_hours,
      forgot_checkout: forgot_checkout,
      anyInvalid: anyInvalid}
  end

  # return the weeks summary of the mentor (total hours, etc) for every week
  def weeks_summary
    summary =[]
    if self.checkins.count > 0
      first_week = self.first_week
      week_date = Time.current
      while week_date >= first_week do
        summary.push(totalhours(week_date))
        week_date = week_date.last_week
      end
    end
    summary
  end

  # return the beginning_of_week of the earliest checkin record for the mentor
  def first_week
      sorted_checkins = Checkin.where(["mentor_id = ?", self.id]).order('checkin_time ASC')
      first_checkin_time = sorted_checkins.first.checkin_time
      first_week = first_checkin_time.beginning_of_week
  end

  def accumulated_hours
    acc_hours = 0
    weeks_summary.each do |week|
        acc_hours += week[:num_hours]
    end
    return acc_hours
  end
end
