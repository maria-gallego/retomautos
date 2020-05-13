# frozen_string_literal: true
module GoogleAnalytics
  TRACKING_ID = Rails.application.credentials.google_analytics_id
  JS_URL = "https://www.googletagmanager.com/gtag/js?id=#{GoogleAnalytics::TRACKING_ID}"
end