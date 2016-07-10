class Contactmessage < ActiveRecord::Base
  after_create :send_email_message

  validates :name, presence: true, length: {minimum: 3}
  validates :message, presence: true, length: {minimum: 3}
  validates :email, presence: true, length: {minimum: 3}
  
  def send_email_message 
    NotificationMailer.contact_message_email(self).deliver_now
  end
end
