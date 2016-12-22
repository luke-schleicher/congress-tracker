desc "This weekly email task is called by the Heroku scheduler add-on"

task :weekly_emails => :environment do
  puts "Sending emails..."
  User.send_weekly_emails
  puts "Emails sent"
end