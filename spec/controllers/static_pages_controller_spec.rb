require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'static_pages#index' do
    render_views
    it 'should display index page on load' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'static_pages#admin' do
    render_views
    
    it 'should require admin to be logged in' do
      get :admin
      expect(response).to redirect_to new_admin_session_path
    end

    it 'should display admin landing page' do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get :admin
      expect(response).to have_http_status(:success)
    end

  end
end
