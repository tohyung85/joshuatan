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
    it 'should display admin landing page' do
      get :admin
      expect(response).to have_http_status(:success)
    end
  end
end
