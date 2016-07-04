require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'static_pages#index' do 
    render_views
    it 'should display index page on load' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
