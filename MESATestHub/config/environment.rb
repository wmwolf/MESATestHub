# Load the Rails application.
require_relative 'application'

# TODO: FINISH THIS (perhaps belongs in environments/*.rb)
# ActionMailer::Base.smtp_settings = {
#   user_name: ENV['SENDGRID_USERNAME'],
#   password: ENV['SENDGRID_PASSWORD'],
#   domain: 'testhub.mesastar.org',
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   authentication: :plain,
#   enable_starttls_auto: true
# }

# Initialize the Rails application.
Rails.application.initialize!
