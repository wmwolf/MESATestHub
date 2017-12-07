desc 'Look for tests failed in the last 24 hours and mail out a summary to '\
     'mesa-developers.'
task morning_mail: :environment do
  puts 'Sending out morning e-mail...'
  MorningMailer.morning_email.deliver!
  puts 'done.'
end
