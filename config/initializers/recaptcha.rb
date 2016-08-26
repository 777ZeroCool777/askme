Recaptcha.configure do |config|
  config.public_key = ENV['RECAPTCHA_ASKME_BUBLIC_KEY']
  config.private_key = ENV['RECAPTCHA_ASKME_PRIVATE_KEY']
end