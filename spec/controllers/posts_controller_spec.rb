require 'spec_helper'

describe PostsController do
  before do
    5.times { create(:post) }
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "has 5 posts" do
      get :index
      assigns(:posts).size.should eq(5)
    end

    it "retrieves the posts is orderded by created at" do
      get :index
      assigns(:posts).should == Post.order('created_at DESC')
    end
  end

  describe "GET #show" do
    context "with valid post ID" do
      let(:post) { create(:post) }

      it "responds successfully with an HTTP 200 status code" do
        get :show, :id => post.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        get :show, :id => post.id
        expect(response).to render_template("show")
      end
    end

    context "with invalid member ID" do
      it "is a 404" do
        expect { get :show, :id => 'wtfisthis' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  pending "TODO: write new, create, edit, update, destroy specs"
end