json.extract! checkin, :id, :checkin_time, :latitude, :longitude, :mentor_id, :school_id, :created_at, :updated_at
json.url checkin_url(checkin, format: :json)
