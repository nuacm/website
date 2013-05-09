class MembersController < ApplicationController

  # Set the @member for all actions that expect a member to
  # already exist.
  before_filter :except => [:index, :new, :create] do
    @member = Member.find(params[:id])
  end

  # Authenticate @member before edit/update and destroy.
  before_filter :only => [:edit, :update, :destroy] do
    authorize! :is => @member
  end

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params :allow_password => true)

    if @member.save
      login! @member
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
    logout! if authorize :is => @member
    redirect_to members_path, :notice => "Member deleted successfully."
  end

  private

  # Requires
  # * `:member`
  # Permits
  # * `:full_name`
  # * `:email`
  #
  def member_params(options = {})
    required = params.require(:member)
    if options[:allow_password]
      required.permit(:full_name, :email, :password, :password_confirmation)
    else
      required.permit(:full_name, :email)
    end
  end
end
