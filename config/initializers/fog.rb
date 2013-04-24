CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => '***REMOVED***',
    :aws_secret_access_key  => '***REMOVED***',
  }
  config.fog_directory  = Rails.env == 'development' ? 'bandwagon_development' : 'bandwagon_production'
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
