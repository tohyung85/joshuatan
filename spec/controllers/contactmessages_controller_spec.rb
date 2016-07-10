require 'rails_helper'

RSpec.describe ContactmessagesController, type: :controller do
  describe 'contactmessages#create' do 
    render_views
    it 'should create a new message in the database' do
      post :create, contactmessage: {
        name: 'A User',
        email: 'auser@email.com',
        message: 'this is a test message'
      }

      expect(response).to redirect_to contact_path

      message = Contactmessage.last
      expect(message.name).to eq('A User')
      expect(message.email).to eq('auser@email.com')
      expect(message.message).to eq('this is a test message')
    end
  end
end
