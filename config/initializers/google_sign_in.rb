Rails.application.configure do
  config.google_sign_in.client_id = Figaro.env.google_sign_in_client_id
  config.google_sign_in.client_secret = Figaro.env.google_sign_in_client_secret
end
