class PasswordResetsController < ApplicationController
  def create
    member = Member.find_by_email(params[:email])
    member.send_password_reset if member
    redirect_to home_path, :notice => "Email sent to <b>#{params[:email]}</b> with password reset instructions.".html_safe
  end

  def edit
    key = Key.find_by_token(params[:reset_token])
    @member = key.keyable if key

    if @member && @member.password_reset_key.good?
      render :edit
    else
      redirect_to new_password_reset_path, :alert => "Invalid password reset token, Try again."
    end
  end

  def update
    key = Key.find_by_token(params[:reset_token])
    @member = key.keyable if key

    if @member.nil? || @member.password_reset_key.bad?
      redirect_to new_password_reset_path, :alert => "Invalid password reset token, Try again."
    elsif @member.update_attributes(reset_password_params)
      @member.password_reset_key.destroy
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
