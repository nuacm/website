class MembersController < ApplicationController

  # POST '/forgot-password'
  def forgot_password
    @member = Member.find_by_email(params[:email])
    if @member
      @member.forgot_password!
    else
      redirect_to :back, :flash => { :error => "No member with email #{params[:email]} found." }
    end
  end

end
