class Message < ApplicationRecord
  belongs_to :user

  validates :subject, presence: true, length: { maximum: 200 }
  validates :body,    presence: true

  scope :sent,   -> { where('sent_at IS NOT NULL').order('sent_at DESC') }
  scope :drafts, -> { where(sent_at: nil).order('created_at DESC') }

  def sent?
    sent_at.present?
  end

  def broadcast!(mailer_class, slack_service)
    recipients    = Recipient.all
    slack_channels = SlackChannel.all

    recipients.each do |recipient|
      mailer_class.conference_message(self, recipient).deliver
    end

    slack_channels.each do |channel|
      slack_service.post(channel.webhook_url, self)
    end

    update_column(:sent_at, Time.current)
  end
end
