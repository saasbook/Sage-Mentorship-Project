module NavigationHelpers

  def path_to(page_name)
    case page_name

        when /^home$/ then root_path

        when /^new_school$/ then new_school_path
        when /^new_super$/ then new_super_path
        when /^new_admin$/ then new_admin_path
        when /^new_mentor$/ then new_mentor_path
        when /^new_checkin$/ then new_checkin_path
        when /^new_checkout$/ then new_checkout_path

        when /^schools_index$/ then schools_path
        when /^supers_index$/ then supers_path
        when /^admins_index$/ then admins_path
        when /^mentors_index$/ then mentors_path

        when /^edit_school, (.*)$/
            name = page_name.match(/^edit_school, (.*)$/).captures[0]
            return edit_school_path(School.find_by_name(name))

        when /^edit_super, (.*)$/
            name = page_name.match(/^edit_super, (.*)$/).captures[0]
            return edit_super_path(Super.find_by_name(name))

        when /^edit_admin, (.*)$/
            name = page_name.match(/^edit_admin, (.*)$/).captures[0]
            return edit_admin_path(Admin.find_by_name(name))

        when /^edit_mentor, (.*)$/
            name = page_name.match(/^edit_mentor, (.*)$/).captures[0]
            return edit_mentor_path(Mentor.find_by_name(name))

        when /^edit_checkin, (.*)$/
            mentor_name, time = page_name.match(/^edit_checkin, (.*), (.*)$/).captures
            mentor_id = Mentor.find_by_name(mentor_name).id
            time = Time.strptime(time, "%Y-%m-%d %H:%M:%S")
            checkin = Checkin.where(mentor_id: mentor_id, checkin_time: time).first
            return edit_checkin_path(checkin)

        when /^edit_checkout, (.*)$/
            mentor_name, time = page_name.match(/^edit_checkout, (.*), (.*)$/).captures
            mentor_id = Mentor.find_by_name(mentor_name).id
            time = Time.strptime(time, "%Y-%m-%d %H:%M:%S")
            checkout = Checkout.where(mentor_id: mentor_id, checkout_time: time).first
            return edit_checkout_path(checkout)


        when /^super_account_management, (.*)$/
            super_name = page_name.match(/^super_account_management, (.*)$/).captures
            super_user = Super.find_by_name(super_name)
            return super_path(super_user)

        when /^admin's_school_activity, (.*)$/
            admin_name = page_name.match(/^admin's_school_activity, (.*)$/).captures
            admin = Admin.find_by_name(admin_name)
            return admin_path(admin)

        when /^school_activity, (.*)$/
            if page_name =~ /^school_activity, (.*), (.*)$/
                school_name, week_date = page_name.match(/^school_activity, (.*), (.*)$/).captures
                school = School.find_by_name(school_name)
                return school_path(school, :week_date => week_date)
            else
                school_name = page_name.match(/^school_activity, (.*)$/).captures
                school = School.find_by_name(school_name)
                return school_path(school)
            end

        when /^mentor_geoloc_appointment, (.*)$/
            mentor_name = page_name.match(/^mentor_geoloc_appointment, (.*)$/).captures
            mentor = Mentor.find_by_name(mentor_name)
            return mentor_path(mentor)

        when /^weeks_summary, (.*)$/
            mentor_name = page_name.match(/^weeks_summary, (.*)$/).captures
            mentor = Mentor.find_by_name(mentor_name)
            return mentor_details_path(mentor)

        when /^attendances_list, (.*), (.*)$/
            mentor_name, week_date = page_name.match(/^attendances_list, (.*), (.*)$/).captures
            mentor = Mentor.find_by_name(mentor_name)
            return mentor_attendances_path(mentor, :week_date => week_date)

        when /^show_checkin, (.*)$/
            mentor_name, time = page_name.match(/^show_checkin, (.*), (.*)$/).captures
            mentor_id = Mentor.find_by_name(mentor_name).id
            time = Time.strptime(time, "%Y-%m-%d %H:%M:%S")
            checkin = Checkin.where(mentor_id: mentor_id, checkin_time: time).first
            return checkin_path(checkin)
    end
  end
end
World(NavigationHelpers)


#  Examples of using the path_to()
#
#  Given I am on the "homepage" page
#
#  Given I am on the "schools_index" page
#  Given I am on the "supers_index" page
#  Given I am on the "admins_index" page
#  Given I am on the "mentors_index" page
#
#  Given I am on the "new_school" page
#  Given I am on the "new_super" page
#  Given I am on the "new_admin" page
#  Given I am on the "new_mentor" page
#  Given I am on the "new_checkin" page
#  Given I am on the "new_checkout" page
#
#  Given I am on the "edit_school, Berkeley Arts Magnet School" page
#  Given I am on the "edit_super, Jasamine" page
#  Given I am on the "edit_admin, Darain" page
#  Given I am on the "edit_mentor, Emma" page
#  Given I am on the "edit_checkin, Emma, 2019-12-2 13:00:00" page
#  Given I am on the "edit_checkout, Emma, 2019-12-4 10:00:00" page
#
#
#  Given I am on the "super_account_management, Jasamine" page
#  Given I am on the "admin's_school_activity, Darain" page
#  Given I am on the "school_activity, Berkeley Arts Magnet School" page
#  Given I am on the "school_activity, Berkeley Arts Magnet School, 12/02/2019" page
#  Given I am on the "weeks_summary, Joseph" page
#  Given I am on the "attendances_list, Kyler, 11/18/2019" page
#  Given I am on the "mentor_geoloc_appointment, Joseph" page
#  Given I am on the "show_checkin, Emma, 2019-12-2 13:00:00" page
