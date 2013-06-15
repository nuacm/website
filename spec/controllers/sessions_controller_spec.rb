require 'spec_helper'

describe SessionsController do
  let(:member) { create(:member) }

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before { @controller.send(:logout!) }

    context "with valid params" do
      let(:params) { {:email => member.email, :password => member.password} }

      it "creates a new session" do
        post :create, params
        @controller.send(:logged_in?, {:as_member => member}).should be_true
      end

      it "redirects to home view" do
        post :create, params
        expect(response).to redirect_to(home_path)
      end

      it "has a notice flash message" do
        post :create, params
        flash[:notice].should_not be_nil
      end

      it "sets a cookie" do
        member = Member.find_by_email(params[:email])
        post :create, params
        cookies[:auth_token].should eq(member.auth_token)
      end
    end

    context "with invalid params" do
      let(:params) { {:email => "baz", :password => ""} }

      it "doesn't log in a member" do
        post :create, params
        @controller.send(:logged_in?).should_not be_true
      end

      it "renders the new template" do
        post :create, params
        expect(response).to render_template("new")
      end

      it "has a alert flash message" do
        post :create, params
        flash[:alert].should_not be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    before { @controller.send(:login!, member) }

    it "logs out the current member" do
      delete :destroy
      @controller.send(:logged_in?).should_not be_true
    end

    it "removes the auth_token from the cookie" do
      delete :destroy
      cookies[:auth_token].should be_nil
    end

    it "redirects to home view" do
      delete :destroy
      expect(response).to redirect_to(home_path)
    end
  end
end
