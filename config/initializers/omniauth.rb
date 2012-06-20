Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps , domain: 'reallyenglish.com' # ENV['OMNIAUTH_DOMAIN']
end
