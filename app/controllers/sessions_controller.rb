class SessionsController < ApplicationController
  def create
    member = Member.find_by_email(params[:email])
    if member && member.authenticate(params[:password])
      login! member
      redirect_to home_path, notice: "Logged in."
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    logout!
    redirect_to home_path, :notice => "Logged out."
  end
end
