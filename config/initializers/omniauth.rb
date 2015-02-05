Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :foursquare, ENV["CLIENT_ID"], ENV["CLIENT_SECRET"]
end
