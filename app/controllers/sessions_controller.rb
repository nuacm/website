class SessionsController < ApplicationController
  def new
    params[:remember_me] = true
  end

  def create
    member = Member.find_by_email(params[:email])
    if member && member.authenticate(params[:password])
      login! member, :remember_me => params[:remember_me]
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
