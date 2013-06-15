require 'spec_helper'

describe PasswordResetsController do
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
    context "with valid params" do
      let(:params) { {:email => member.email} }

      it "sends an email" do
        post :create, params
        ActionMailer::Base.deliveries.size.should eq(1)
      end

      it "sends an email to the member" do
        post :create, params
        email = ActionMailer::Base.deliveries.first
        email.to.should include(member.email)
      end

      it "creates a reset token for the member" do
        post :create, params
        member.reload.password_reset_token.should_not be_nil
      end

      it "sends email with a link to reset the member's password" do
        post :create, params
        email = ActionMailer::Base.deliveries.first
        reset_token = member.reload.password_reset_token
        url = edit_password_reset_url(:reset_token => reset_token)
        email.body.raw_source.should include(url)
      end

      it "redirects to home view" do
        post :create, params
        expect(response).to redirect_to(home_path)
      end

      it "has a notice flash message" do
        post :create, params
        flash[:notice].should include("Email sent")
      end
    end

    context "with invalid params" do
      let(:params) { {:email => "doesnotexist@unknown.com"} }

      it "doesn't send an email" do
        post :create, params
        ActionMailer::Base.deliveries.should be_empty
      end

      it "redirects to home view" do
        post :create, params
        expect(response).to redirect_to(home_path)
      end

      it "has a notice flash message" do
        post :create, params
        flash[:notice].should include("Email sent")
      end
    end
  end

  describe "GET #edit" do
    context "with valid reset password token" do
      before(:each) { member.send_password_reset }
      let(:params)  { {:reset_token => member.password_reset_token} }

      it "responds successfully with an HTTP 200 status code" do
        get :edit, params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do
        get :edit, params
        expect(response).to render_template("edit")
      end
    end

    context "with invalid reset password token" do
      let(:params) { {:reset_token => "notevenatoken"} }

      it "redirects to new page" do
        get :edit, params
        expect(response).to redirect_to(new_password_reset_path)
      end

      it "displays a flash alert" do
        get :edit, params
        flash[:alert].should_not be_nil
      end
    end

    context "with expired token" do
      before(:each) do
        member.send_password_reset
        Timecop.travel(Time.now + 2.hours)
      end
      let(:params) { {:reset_token => member.password_reset_token} }

      it "redirects to the new page" do
        get :edit, params
        expect(response).to redirect_to(new_password_reset_path)
      end

      it "displays a alert flash" do
        get :edit, params
        flash[:alert].should_not be_nil
      end
    end
  end

  describe "PUT/PATCH #update" do
    context "with valid params" do
      before(:each) { member.send_password_reset }
      let(:params) do
        { :reset_token => member.password_reset_token,
          :member => {
            :password              => "updatedPassword",
            :password_confirmation => "updatedPassword"
          }
        }
      end

      it "updates the members password" do
        patch :update, params
        member.reload.authenticate("updatedPassword").should be_true
      end

      it "removes the password reset token" do
        patch :update, params
        member.reload
        member.password_reset_token.should be_nil
        member.password_reset_sent_at.should be_nil
      end

      it "redirects to the home page" do
        patch :update, params
        expect(response).to redirect_to(home_path)
      end

      it "sets a notice flash" do
        patch :update, params
        flash[:notice].should_not be_nil
      end
    end

    context "with invalid params" do
      context "bad token" do
        let(:params) do
          { :reset_token => "notevenatoken",
            :member => {
              :password              => "updatedPassword",
              :password_confirmation => "updatedPassword"
            }
          }
        end

        it "redirects to new page" do
          patch :update, params
          expect(response).to redirect_to(new_password_reset_path)
        end

        it "displays a flash alert" do
          patch :update, params
          flash[:alert].should_not be_nil
        end
      end

      context "unmatching passwords" do
        before(:each) { member.send_password_reset }
        let(:params) do
          { :reset_token => member.password_reset_token,
            :member => {
              :password              => "updatedPassword",
              :password_confirmation => "updated"
            }
          }
        end

        it "renders the edit page" do
          patch :update, params
          expect(response).to render_template("edit")
        end

        it "has a member with errors" do
          patch :update, params
          assigns(:member).errors.should_not be_empty
        end
      end

      context "expired token" do
        before(:each) do
          member.send_password_reset
          Timecop.travel(Time.now + 2.hours)
        end
        let(:params) do
          { :reset_token => member.password_reset_token,
            :member => {
              :password              => "updatedPassword",
              :password_confirmation => "updated"
            }
          }
        end

        it "redirects to the new page" do
          patch :update, params
          expect(response).to redirect_to(new_password_reset_path)
        end

        it "displays a alert flash" do
          patch :update, params
          flash[:alert].should_not be_nil
        end
      end
    end
  end

end
