class MembersController < ApplicationController

  # Set the @member for all actions that expect a member to
  # already exist.
  before_filter :except => [:index, :new, :create] do
    @member = Member.find(params[:id])
  end

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member
    else
      render :new
    end
  end

  def update
    if @member.update_attributes(member_params)
      redirect_to @member
    else
      render :edit
    end
  end

  def destroy
    @member.destroy

    redirect_to members_path
  end

  private

  # Requires
  # * `:member`
  # Permits
  # * `:full_name`
  # * `:email`
  #
  def member_params
    params.require(:member).permit(:full_name, :email)
  end
end
