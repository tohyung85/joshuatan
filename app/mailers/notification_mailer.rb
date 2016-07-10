class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def contact_message_email(message)
    @message = message
    mail(from: @message.email, to: 'tantohyung@gmail.com', subject: "#{@message.name} has sent you a message!")
  end
end
