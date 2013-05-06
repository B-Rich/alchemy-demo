Airbrake.configure do |config|
  # disable ssl certificate verification
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  config.api_key = ENV['ERRBIT_API_KEY']
  config.host    = ENV['ERRBIT_HOST']
  config.port    = 443
  config.secure  = config.port == 443
end
