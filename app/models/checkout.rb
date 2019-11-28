class Checkout < ApplicationRecord
	belongs_to :mentor

	def correspond_checkin
		checkout_time = self.checkout_time
		checkin = Checkin.where("mentor_id = :mentor_id and school_id = :school_id
                and checkin_time < :checkout_time
                and checkin_time >= :same_day_start
                and checkin_time <= :same_day_end",
															:mentor_id => self.mentor_id,
															:school_id => self.school_id                ,
															:checkout_time => checkout_time,
															:same_day_start => checkout_time.beginning_of_day.utc,
															:same_day_end => checkout_time.end_of_day.utc).first
	end
end
