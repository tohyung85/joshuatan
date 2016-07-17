require 'rails_helper'

RSpec.describe Admin::BlogpostsController, type: :controller do
  describe 'blogposts#new' do
    render_views
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

  describe 'blogposts#create' do 
    it 'should create blogpost' do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      post :create, blogpost: {
        title: 'Hello',
        content: 'Somemore stuff',
        category: 'Others',
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png')) 
      }
      expect(response).to redirect_to admin_path
      expect(Blogpost.count).to eq 1
    end

    it 'should validate inputs' do 
      admin = FactoryGirl.create(:admin)
      sign_in admin
      post :create, blogpost: {
        title: '',
        content: '',
        category: '',        
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png'))         
      }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Blogpost.count).to eq 0
    end

    it 'should require admin to be signed in' do 
      post :create, blogpost: {
        title: 'Hacked',
        content: 'Inserting hack',
        category: 'Naughty business',        
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png'))         
      }
      expect(response).to redirect_to new_admin_session_path
      expect(Blogpost.count).to eq 0      
    end

  end

  describe 'blogposts#update' do
    it 'should update blogpost' do
      blogpost = FactoryGirl.create(:blogpost)
      admin = FactoryGirl.create(:admin)
      sign_in admin
      patch :update, id: blogpost.id, blogpost: {
        title: 'Nice Post',
        content: 'changedstuff',
        category: 'Technical',
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png')) 
      }
      expect(response).to redirect_to admin_path

      blogpost.reload

      expect(blogpost.title).to eq("Nice Post")
      expect(blogpost.content).to eq("changedstuff")
      expect(blogpost.category).to eq("Technical")
    end

    it 'should require admin to be logged in' do
      blogpost = FactoryGirl.create(:blogpost)
      patch :update, id: blogpost.id, blogpost: {
        title: 'Nice Post',
        content: 'changedstuff',
        category: 'Technical',
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png')) 
      }
      expect(response).to redirect_to new_admin_session_path

      blogpost.reload

      expect(blogpost.title).to eq("Awesome Post")
      expect(blogpost.content).to eq("Somestuff")
      expect(blogpost.category).to eq("Others")            
    end

    it 'should have a 404 error if gram is not found' do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      patch :update, id: 'id2', blogpost: {
        title: 'Nice Post',
        content: 'changedstuff',
        category: 'Technical',
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png')) 
      }
      expect(response).to have_http_status(:not_found)
    end

    it 'should render edit form if an http status of unprocessable entity is raised' do
      blogpost = FactoryGirl.create(:blogpost)
      admin = FactoryGirl.create(:admin)
      sign_in admin
      patch :update, id: blogpost.id, blogpost: {
        title: '',
        content: 'changedstuff',
        category: 'Technical',
        publish: true,
        publish_date: 'Jul 17 2016',
        image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'angrybirds.png')) 
      }
      expect(response).to have_http_status(:unprocessable_entity)

      blogpost.reload
      
      expect(blogpost.title).to eq("Awesome Post")


    end
  end

  describe 'blogposts#edit' do     
    render_views
    it 'should display page to edit' do
      blogpost = FactoryGirl.create(:blogpost)
      admin = FactoryGirl.create(:admin)
      sign_in admin      
      get :edit, id: blogpost.id
      expect(response).to have_http_status(:success)
    end

    it 'should require admin to be signed in' do
      blogpost = FactoryGirl.create(:blogpost)
      get :edit, id: blogpost.id
      expect(response).to redirect_to new_admin_session_path
    end

    it 'should return 404 error if post not found' do 
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get :edit, id: '2'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'blogpost#delete' do 
    it 'should delete blogpost' do
      blogpost = FactoryGirl.create(:blogpost, title:'something')
      admin = FactoryGirl.create(:admin)
      sign_in admin
      delete :destroy, id: blogpost.id
      expect(Blogpost.count).to eq 0
      expect{ blogpost.reload }.to raise_exception(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to admin_path
    end

    it 'should require admin login' do
      blogpost = FactoryGirl.create(:blogpost)
      delete :destroy, id: blogpost.id
      expect(response).to redirect_to new_admin_session_path
      expect(Blogpost.count).to eq 1
    end

    it 'should return 404 error if post not found' do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      delete :destroy, id: 'someid'
      expect(response).to have_http_status(:not_found)
    end
  end
end
