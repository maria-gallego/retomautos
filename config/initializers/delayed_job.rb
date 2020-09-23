# @see https://devcenter.heroku.com/articles/delayed-job
# Sets delayed job as the queue adapter for active job
Rails.application.config.active_job.queue_adapter = :delayed_job
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_attempts = 15 # The last retry will be 43 hours after the original
Delayed::Worker.default_priority = 10
Delayed::Worker.sleep_delay = 60 # If no jobs are found, the worker sleeps for the amount of time specified
Delayed::Worker.default_queue_name = 'default'
Delayed::Worker.read_ahead = 10
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.delay_jobs != Rails.env.test?
Delayed::Worker.logger = Rails.logger
