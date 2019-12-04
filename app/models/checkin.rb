require 'csv'
class Checkin < ApplicationRecord
	belongs_to :mentor

	def school
			School.find(self.school_id)
	end

	# find and return the corresponding checkout,
	# which is on the same day as checkin and occurs after checkin_time
	# assuming that only at most one checkin and one checkout each day

	def correspond_checkout
		checkin_time = self.checkin_time
		checkout = Checkout.where("mentor_id = :mentor_id and school_id = :school_id
                and checkout_time >= :checkin_time
                and checkout_time >= :same_day_start
                and checkout_time <= :same_day_end",
															:mentor_id => self.mentor_id,
															:school_id => self.school_id                ,
															:checkin_time => checkin_time,
															:same_day_start => checkin_time.beginning_of_day,
															:same_day_end => checkin_time.end_of_day).first
	end
end
