require 'spec_helper'

describe EventsController do
  before do
    5.times { create(:event) }
    5.times { create(:talk) }
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

    it "has 10 events" do
      get :index
      assigns(:events).size.should eq(10)
    end

    it "retrieves the events is order of start time" do
      get :index
      assigns(:events).should == Event.order('start_time ASC')
    end
  end

  describe "GET #show" do
    context "with valid event ID" do
      let(:event) { create(:event) }

      it "responds successfully with an HTTP 200 status code" do
        get :show, :id => event.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        get :show, :id => event.id
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