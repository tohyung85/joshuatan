require 'rails_helper'

RSpec.describe Admin::BlogpostsController, type: :controller do
  let(:admin) {FactoryGirl.create(:admin)}
  let(:blogpost) {FactoryGirl.create(:blogpost)}
  let(:blogpost_published) {FactoryGirl.create(:blogpost, published: true, publish_date: Date.current())}

  describe '#publish' do
    context 'admin is signed in' do
      it 'should set published in model to true and set publish date to current date' do
        sign_in admin
        get :publish, blogpost_id: blogpost.id
        
        blogpost.reload

        expect(response).to redirect_to admin_path
        expect(blogpost.published).to eq(true)
        expect(blogpost.publish_date).to eq(Date.current())
      end

      it 'should unpublish if blog is already published' do
        sign_in admin
        get :publish, blogpost_id: blogpost_published.id 

        blogpost_published.reload

        expect(response).to redirect_to admin_path
        expect(blogpost_published.published).to eq(false)
        expect(blogpost_published.publish_date).to eq(nil)
      end
    end    

    context 'admin is not signed in' do
      it 'should send user to login page' do
        get :publish, blogpost_id: blogpost.id
        expect(response).to redirect_to new_admin_session_path
        expect(blogpost.published).to eq false
        expect(blogpost.publish_date).to eq nil
      end
    end

    context 'no blogpost available' do
      it 'should return a 404 error' do
        sign_in admin
        get :publish, blogpost_id: 'someid'
        expect(response).to have_http_status(:not_found)
      end
    end

  end

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
        published: false,
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
        published: false,
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
        published: false,
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
        published: false,
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
        published: false,
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
        published: false,
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
        published: false,
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
