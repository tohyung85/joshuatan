require 'rails_helper'

RSpec.describe ContactmessagesController, type: :controller do
  describe 'contactmessages#new' do
    render_views
    it 'should display Contact Page on load' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end  

  describe 'contactmessages#create' do 
    render_views
    it 'should create a new message in the database' do
      post :create, contactmessage: {
        name: 'Test User',
        email: 'testuser@gmail.com',
        message: 'test message'
      }

      expect(response).to redirect_to new_contactmessage_path

      message = Contactmessage.last
      expect(message.name).to eq('Test User')
      expect(message.email).to eq('testuser@gmail.com')
      expect(message.message).to eq('test message')
    end

    it 'should properly deal with name validation errors' do
      post :create, contactmessage: {
        name: 'ab',
        email: 'test@gmail.com',
        message: 'test message'
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Contactmessage.count).to eq 0
    end
  end
end
