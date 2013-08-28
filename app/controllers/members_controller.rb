class MembersController < ApplicationController

  # Set the @member for all actions that expect a member to
  # already exist.
  before_filter :except => [:index, :new, :create] do
    @member = Member.find(params[:id])
  end

  # Authenticate @member before edit/update and destroy.
  before_filter :only => [:edit, :update, :destroy, :change_password] do
    logged_in! :as_member => @member, :as_officer => true
  end

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    if params[:member][:password]
      @member = SecureMember.new(member_params :allow_password => true)
    else
      @member = Member.new(member_params)
    end

    if @member.save
      login! @member if params[:member][:password]
      redirect_to @member, :notice => "Signed up successfully."
    else
      render :new
    end
  end

  def update
    if @member.update_attributes(member_params)
      redirect_to @member, :notice => "Updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    logout! if logged_in? :as_member => @member
    redirect_to members_path, :notice => "Member deleted successfully."
  end

  def change_password
    if @member.authenticate change_password_params.delete(:old_password)
      attrs = change_password_params.reject { |k| k.to_sym == :old_password }
      if @member.update_attributes(attrs)
        redirect_to @member, :notice => "Password changed successfully."
      else
        render :edit
      end
    else
      @member.errors[:old_password] = "is not correct."
      render :edit
    end
  end

  private

  # Requires
  # * `:member`
  # Permits
  # * `:name`
  # * `:email`
  #
  def member_params(options = {})
    required = params.require(:member)
    if options[:allow_password]
      required.permit(:name, :email, :password, :password_confirmation)
    else
      required.permit(:name, :email)
    end
  end

  # Requires
  # * `:password`
  # Permits
  # * `:old_password`
  # * `:password`
  # * `:password_confirmation`
  #
  def change_password_params
    params.require(:password).permit(:old_password, :password, :password_confirmation)
  end
end
