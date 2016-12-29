class DailyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # recurrence { daily(1) }
  recurrence { secondly(30) }

  def perform
    User.send_daily_digest
  end
end
