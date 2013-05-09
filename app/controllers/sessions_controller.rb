class SessionsController < ApplicationController
  def new
  end

  def create
    member = Member.find_by_email(params[:email])
    if member && member.authenticate(params[:password])
      session[:member_id] = member.id
      redirect_to home_path, notice: "Logged in."
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:member_id] = nil
    redirect_to home_path, :notice => "Logged out."
  end
end
