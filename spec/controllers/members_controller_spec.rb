require 'spec_helper'

describe MembersController do
  before do
    5.times { create(:member) }
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

    it "has 5 members" do
      get :index
      assigns(:members).size.should eq(5)
    end
  end

  describe "GET #show" do
    context "with valid member ID" do
      let(:member) { create(:member) }

      it "responds successfully with an HTTP 200 status code" do
        get :show, :id => member.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the show template" do
        get :show, :id => member.id
        expect(response).to render_template("show")
      end
    end

    context "with invalid member ID" do
      it "is a 404" do
        expect { get :show, :id => 'wtfisthis' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

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

    it "assigns a new member" do
      get :new
      assigns(:member).should be_new_record
    end
  end

  describe "POST #create" do
    context "with valid params" do
      context "for basic member" do
        let(:params) { attributes_for(:member) }

        it "creates a new record for the member" do
          post :create, :member => params
          assigns(:member).should be_persisted
          assigns(:member).email.should eq(params[:email])
        end

        it "redirects to show view" do
          post :create, :member => params
          expect(response).to redirect_to(member_path(assigns(:member)))
        end

        it "has a notice flash message" do
          post :create, :member => params
          flash[:notice].should_not be_nil
        end

        it "doesn't log in the member" do
          post :create, :member => params
          @controller.send(:logged_in?, {:as_member => assigns(:member)}).should_not be_true
        end
      end

      context "for secure member" do
        let(:params) { attributes_for(:secure_member) }

        it "creates a new record for the member" do
          post :create, :member => params
          assigns(:member).should be_persisted
          assigns(:member).email.should eq(params[:email])
        end

        it "redirects to show view" do
          post :create, :member => params
          expect(response).to redirect_to(member_path(assigns(:member)))
        end

        it "has a notice flash message" do
          post :create, :member => params
          flash[:notice].should_not be_nil
        end

        it "logs in the member" do
          post :create, :member => params
          @controller.send(:logged_in?, {:as_member => assigns(:member)}).should be_true
        end
      end
    end

    context "with invalid params" do
      it "requires member parameter" do
        expect { post :create, :foobar => {} }.to raise_error
      end

      context "with existing email" do
        let!(:member) { create(:member, :email => "test@example.com") }
        let(:bad_email_params) { attributes_for(:member, :email => "test@example.com") }

        it "doesn't create a member" do
          count = Member.count
          post :create, :member => bad_email_params
          Member.count.should eq(count)
        end

        it "renders the new template" do
          post :create, :member => bad_email_params
          expect(response).to render_template("new")
        end

        it "applies email existing error to the member" do
          post :create, :member => bad_email_params
          assigns(:member).errors[:email].should include("has already been taken")
        end
      end

      it "doesn't have a notice flash message" do
        post :create, :member => { :email => 'bad' }
        flash[:notice].should be_nil
      end
    end
  end

  describe "GET #edit" do
    let(:member) { create(:secure_member) }

    shared_examples "an edit with access" do
      it "responds successfully with an HTTP 200 status code" do
        get :edit, :id => member.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the edit template" do
        get :edit, :id => member.id
        expect(response).to render_template("edit")
      end

      it "assigns the member" do
        get :edit, :id => member.id
        assigns(:member).should eq(member)
      end
    end

    context "as logged in member" do
      before { @controller.send(:login!, member) }
      it_behaves_like("an edit with access")
    end

    context "as logged in officer" do
      before { @controller.send(:login!, create(:officer)) }
      it_behaves_like("an edit with access")
    end

    context "as other member" do
      before { @controller.send(:login!, create(:secure_member)) }

      it "redirects home" do
        get :edit, :id => member.id
        expect(response).to redirect_to(home_path)
      end

      it "sets an alert flash" do
        get :edit, :id => member.id
        flash[:alert].should_not be_nil
      end
    end
  end

  describe "PATCH/PUT #update" do
    let(:member) { create(:secure_member) }

    shared_examples "an update with access" do
      context "with valid params" do
        it "updates name" do
          patch :update, :id => member.id, :member => { :name => "Changed Name" }
          member.reload.name.should eq("Changed Name")
        end

        it "updates email" do
          patch :update, :id => member.id, :member => { :email => "change@email.com" }
          member.reload.email.should eq("change@email.com")
        end

        it "redirects to show view" do
          patch :update, :id => member.id, :member => attributes_for(:member)
          expect(response).to redirect_to(member_path(assigns(:member)))
        end

        it "has a notice flash message" do
          patch :update, :id => member.id, :member => attributes_for(:member)
          flash[:notice].should_not be_nil
        end
      end

      context "with invalid params" do
        it "requires member parameter" do
          expect { patch :update, :id => member.id, :foobar => {} }.to raise_error(ActionController::ParameterMissing)
        end

        context "with existing email" do
          before { create(:member, :email => "test@example.com") }

          it "doesn't update a member" do
            patch :update, :id => member.id, :member => { :email => "test@example.com" }
            member.email.should_not eq("test@example.com")
          end

          it "renders the edit template" do
            patch :update, :id => member.id, :member => { :email => "test@example.com" }
            expect(response).to render_template("edit")
          end

          it "applies email existing error to the member" do
            patch :update, :id => member.id, :member => { :email => "test@example.com" }
            assigns(:member).errors[:email].should include("has already been taken")
          end

          it "doesn't have a notice flash message" do
            patch :update, :id => member.id, :member => { :email => "bad" }
            flash[:notice].should be_nil
          end
        end
      end
    end

    context "as logged in member" do
      before { @controller.send(:login!, member) }
      it_behaves_like("an update with access")
    end

    context "as logged in officer" do
      before { @controller.send(:login!, create(:officer)) }
      it_behaves_like("an update with access")

      it "pays dues" do
        patch :update, :id => member.id, :member => {:dues_attributes => {'0' => {:amount => 10}}}
        member.dues.count.should == 1
      end
    end

    context "as not logged in member" do
      before { @controller.send(:logout!) }

      it "redirects home" do
        patch :update, :id => member.id, :member => attributes_for(:member)
        expect(response).to redirect_to(home_path)
      end

      it "sets a alert flash" do
        patch :update, :id => member.id, :member => attributes_for(:member)
        flash[:alert].should_not be_nil
      end
    end

    context "with invalid member ID" do
      it "is a 404" do
        expect { patch :update, :id => 'wtfisthis', :member => attributes_for(:member) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:member) { create(:secure_member) }

    shared_examples "a destroy with access" do
      it "destorys the member" do
        delete :destroy, :id => member.id
        expect { Member.find(member.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "has a notice flash message" do
        delete :destroy, :id => member.id
        flash[:notice].should_not be_nil
      end
    end

    context "as logged in member" do
      before { @controller.send(:login!, member) }
      it_behaves_like("a destroy with access")
    end

    context "as logged in officer" do
      before { @controller.send(:login!, create(:officer)) }
      it_behaves_like("a destroy with access")
    end

    context "when not logged in" do
      before { @controller.send(:logout!) }

      it "redirects home" do
        delete :destroy, :id => member.id
        expect(response).to redirect_to(home_path)
      end

      it "sets a alert flash" do
        delete :destroy, :id => member.id
        flash[:alert].should_not be_nil
      end
    end

    context "with invalid member ID" do
      it "is a 404" do
        expect { delete :destroy, :id => 'wtfisthis' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #change_password" do
    let(:member) { create(:secure_member) }
    let(:params) do
      { :old_password => member.password,
        :password => "gl0ry!ous",
        :password_confirmation => "gl0ry!ous" }
    end

    shared_examples "a change_password with access" do
      context "with valid params" do
        it "changes the password" do
          put :change_password, :id => member.id, :password => params
          member.reload.authenticate("gl0ry!ous").should be_true
        end

        it "redirects to show view" do
          put :change_password, :id => member.id, :password => params
          expect(response).to redirect_to(member_path(assigns(:member)))
        end

        it "has a notice flash message" do
          put :change_password, :id => member.id, :password => params
          flash[:notice].should_not be_nil
        end
      end

      context "with invalid params" do
        it "requires password parameter" do
          expect { put :change_password, :id => member.id, :foobar => {} }.to raise_error(ActionController::ParameterMissing)
        end

        it "checks the old password" do
          params[:old_password] = "sillyness"
          put :change_password, :id => member.id, :password => params
          member.reload.authenticate("gl0ry!ous").should_not be_true
        end

        it "checks the password confirmation" do
          params[:password_confirmation] = "sillyness"
          put :change_password, :id => member.id, :password => params
          member.reload.authenticate("gl0ry!ous").should_not be_true
        end
      end
    end

    context "as logged in member" do
      before { @controller.send(:login!, member) }
      it_behaves_like("a change_password with access")
    end

    context "as logged in officer" do
      before { @controller.send(:login!, create(:officer)) }
      it_behaves_like("a change_password with access")
    end

    context "as not logged in member" do
      before { @controller.send(:logout!) }

      it "redirects home" do
        put :change_password, :id => member.id, :password => params
        expect(response).to redirect_to(home_path)
      end

      it "sets a alert flash" do
        put :change_password, :id => member.id, :password => params
        flash[:alert].should_not be_nil
      end
    end

    context "with invalid member ID" do
      it "is a 404" do
        expect { put :change_password, :id => 'wtfisthis', :password => params }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
