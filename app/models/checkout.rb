class Checkout < ApplicationRecord
	belongs_to :mentor

	def school
			School.find(self.school_id)
	end

	# find and return the corresponding checkin,
	# which is on the same day as checkout and occurs before checkout_time
	# assuming that only at most one checkin and one checkout each day

	def correspond_checkin
		checkout_time = self.checkout_time
		checkin = Checkin.where("mentor_id = :mentor_id and school_id = :school_id
                and checkin_time <= :checkout_time
                and checkin_time >= :same_day_start
                and checkin_time <= :same_day_end",
															:mentor_id => self.mentor_id,
															:school_id => self.school_id,
															:checkout_time => checkout_time,
															:same_day_start => checkout_time.beginning_of_day.utc,
															:same_day_end => checkout_time.end_of_day.utc).first
	end
end
