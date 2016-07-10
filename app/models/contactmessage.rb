class Contactmessage < ActiveRecord::Base
  after_create :send_email_message
  def send_email_message 
    NotificationMailer.contact_message_email(self).deliver_now
  end
end
