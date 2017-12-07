# Preview all emails at http://localhost:3000/rails/mailers/morning_mailer
require 'send-grid-ruby'
class MorningMailerPreview < ActionMailer::Preview
  include SendGrid
  def morning_email
    MorningMailer.morning_email
  end
end
