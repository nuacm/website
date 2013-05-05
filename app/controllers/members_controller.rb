class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params :password => true)

    if @member.save
      redirect_to @member
    else
      render :new
    end
  end

  def update
    @member = Member.find(params[:id])

    if @member.update_attributes(member_params)
      redirect_to @member
    else
      render :edit
    end
  end

  def destroy
    @member = Member.find(params[:id])

    @member.destroy
    redirect_to members_path
  end

  # POST '/forgot-password'
  def forgot_password
    @member = Member.find_by_email(params[:email])

    if @member
      @member.forgot_password!
    else
      redirect_to :back, :flash => { :error => "No member with email #{params[:email]} found." }
    end
  end

  private

  # Setup the strong_parameters for this controller.
  # Require that :member be set and allow :full_name, and
  # :email to be passed.
  # If options[:password] is true also allow a password to be
  # sent.
  def member_params(options = {})
    required = params.require(:member)
    if options[:password]
      required.permit(:full_name, :email, :password, :password_confirmation)
    else
      required.permit(:full_name, :email)
    end
  end
end
