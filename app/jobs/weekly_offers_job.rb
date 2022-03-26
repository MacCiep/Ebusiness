class WeeklyOffersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # puts 'Im working!'
    WeekendOffersMailer.weekly_notifier(User.find_by(email: 'guestay.info@gmail.com')).deliver_later
  end
end
