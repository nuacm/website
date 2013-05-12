class PasswordResetsController < ApplicationController
  def create
    member = Member.find_by_email(params[:email])
    member.send_password_reset if member
    redirect_to home_path, :notice => "Email sent to #{params[:email]} with password reset instructions."
  end

  def edit
    @member = Member.find_by_password_reset_token!(params[:id])
  end

  def update
    @member = Member.find_by_password_reset_token!(params[:id])
    if @member.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @member.update_attributes(reset_password_params)
      redirect_to home_path, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  private

  # Requires
  # * `:member`
  # Permits
  # * `:password`
  # * `:password_confirmation`
  #
  def reset_password_params
    params.require(:member).permit(:password, :password_confirmation)
  end
end
