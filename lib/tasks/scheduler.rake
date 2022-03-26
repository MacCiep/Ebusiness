task :weekly_notifier => :environment do
  if Date.today.wday == 5
    puts "Sending weekly notifications"
    WeeklyOffersJob.perform_later
    puts "done."
  end
end