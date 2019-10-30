json.extract! checkout, :id, :checkout_time, :latitude, :longitude, :mentor_id, :school_id, :created_at, :updated_at
json.url checkout_url(checkout, format: :json)
