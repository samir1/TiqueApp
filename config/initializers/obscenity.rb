Obscenity.configure do |config|
  config.blacklist   = "#{Rails.root}/config/blacklist.yml"
  config.whitelist   = ["safe", "word"]
  config.replacement = :stars
end