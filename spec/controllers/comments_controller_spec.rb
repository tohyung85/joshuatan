require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:blogpost) {FactoryGirl.create(:blogpost)}
  describe '#create' do 
    context 'no valid blog id' do
      it 'should return a 404 error' do
        initial_count = Blogpost.count        
        expect {post :create, blogpost_id: 'YOLO', comment: {
          name: 'John Doe',
          message: 'something awesome'
        }}.to_not change {Blogpost.count}.from(initial_count)

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'valid blog id' do
      it 'should create a comment' do
        expect {post :create, blogpost_id: blogpost.id, comment: {
          name: 'John Doe',
          message: 'something nice'
        }}.to change {Blogpost.count}.by(1)

        expect(blogpost.comments.last.name).to eq 'John Doe'   
        expect(blogpost.comments.last.message).to eq 'something nice'             
        expect(response).to redirect_to blogpost_path(blogpost)
      end
    end

  end

end
