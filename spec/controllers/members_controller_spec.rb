require 'spec_helper'

describe MembersController do
  describe "POST #forgot-password" do
    subject { create(:member, :email => "bob.smith@example.com") }
    let(:request_from) { "neverland" }
    before(:each) do
      request.env["HTTP_REFERER"] = request_from
    end

    context "with email that exists" do
      before { post :forgot_password, :email => subject.email }

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the forgot_password template" do
        expect(response).to render_template("forgot_password")
      end

      it "creates a key for the subject" do
        subject.reset_key.should_not be_nil
      end

      it "replaces existing keys from the subject" do
        old_reset_key = subject.reset_key
        post :forgot_password, :email => subject.email # again
        subject.reload.reset_key.should_not eq(old_reset_key)
      end
    end

    context "with email that doesn't exist" do
      before { post :forgot_password, :email => "foo@bar.com" }

      it "redirects back" do
        response.should redirect_to(request_from)
      end

      it "has a flash error" do
        flash[:error].should include("No member with email")
      end
    end
  end
end
