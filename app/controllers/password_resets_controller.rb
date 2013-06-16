class PasswordResetsController < ApplicationController
  def create
    member = Member.find_by_email(params[:email])
    member.send_password_reset if member
    redirect_to home_path, :notice => "Email sent to <b>#{params[:email]}</b> with password reset instructions.".html_safe
  end

  def edit
    @member = Member.find_by_password_reset_token(params[:reset_token])

    if @member.nil? || expired_reset_token?(@member)
      redirect_to new_password_reset_path, :alert => "Invalid password reset token, Try again."
    else
      render :edit
    end
  end

  def update
    @member = Member.find_by_password_reset_token(params[:reset_token])
    if @member.nil? || expired_reset_token?(@member)
      redirect_to new_password_reset_path, :alert => "Invalid password reset token, Try again."
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
    filtered = params.require(:member).permit(:password, :password_confirmation)

    # Remove the member's token and sent_at attributes.
    filtered.merge :password_reset_token   => nil,
                   :password_reset_sent_at => nil
  end

  # expired_reset_token? Member -> boolean
  # Returns true if the given member has an expired reset token.
  def expired_reset_token?(member)
    member.password_reset_sent_at < 2.hours.ago
  end
end
