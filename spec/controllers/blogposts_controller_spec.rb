require 'rails_helper'

RSpec.describe BlogpostsController, type: :controller do
  let(:blogpost) {FactoryGirl.create(:blogpost)}
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
      get :show, id: blogpost.id
      expect(response).to have_http_status(:success)
    end

    it 'should return a 404 error if blogpost not found' do
      get :show, id: 'someid'
      expect(response).to have_http_status(:not_found)
    end
  end

end
