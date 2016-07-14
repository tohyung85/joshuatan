require 'rails_helper'

RSpec.describe BlogpostsController, type: :controller do
  describe 'blogpost#index' do 
    render_views
    it 'should display list of blogposts available' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'blogpost#show' do
    render_views
    it 'should display individual blogpost' do 
      blogpost = FactoryGirl.create(:blogpost)
      get :show, id: blogpost.id
      expect(response).to have_http_status(:success)
    end
  end

end
