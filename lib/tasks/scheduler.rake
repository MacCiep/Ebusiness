task :weekly_notifier => :environment do
  puts "Sending weekly notifications"
  WeeklyOffersJob.perform_later
  puts "done."
end