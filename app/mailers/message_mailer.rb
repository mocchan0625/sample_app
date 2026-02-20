class MessageMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM', 'conference@example.com')

  def conference_message(message, recipient)
    @message   = message
    @recipient = recipient

    mail(
      to:      "\"#{recipient.name}\" <#{recipient.email}>",
      subject: "[カンファレンス] #{message.subject}"
    )
  end
end
