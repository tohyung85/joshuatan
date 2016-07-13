require 'rails_helper'

RSpec.describe Admin::BlogpostsController, type: :controller do
  render_views
  describe 'blogposts#new' do
    it 'should require admin to be logged in' do
      get :new
      expect(response).to redirect_to new_admin_session_path
    end
    it 'should show page to create blog post' do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get :new
      expect(response).to have_http_status(:success)
    end
  end  
end
