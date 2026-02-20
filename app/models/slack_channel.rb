class SlackChannel < ApplicationRecord
  validates :name,        presence: true, length: { maximum: 100 }
  validates :webhook_url, presence: true, format: {
    with: /\Ahttps:\/\/hooks\.slack\.com\/.+\z/,
    message: "はSlack Incoming Webhook URLである必要があります (https://hooks.slack.com/...)"
  }
end
