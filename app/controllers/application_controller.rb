class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_cookies instead.
  protect_from_forgery with: :exception

  private

  # current_member : -> nil or Member
  # Looks up the current member from the cookies :auth_token.
  # The result is cached in the instance variable @current_member.
  #
  def current_member
    if cookies[:auth_token]
      @current_member ||= Member.find_by_auth_token(cookies[:auth_token])
    end
  end
  helper_method :current_member

  # authorize : options -> Boolean
  #
  # Options:
  # :is  - Checks if the current user is the given user.
  # :any - Checks if there is a current user.
  #
  def authorize(options = {})
    options = { options => true } if options.is_a?(Symbol)

    if options[:is]
      current_member == options[:is]
    elsif options[:any]
      !current_member.nil?
    end
  end
  helper_method :authorize

  # authorize!
  # If authorize is false redirect home and alert the user.
  #
  # Options:
  # :is  - Checks if the current user is the given user.
  # :any - Checks if there is a current user.
  #
  def authorize!(options = {})
    redirect_to home_path, :alert => "Not authorized." unless authorize(options)
  end
  helper_method :authorize!

  # login! : Member -> Boolean
  # Sets the :auth_token on the cookies. Effectively logging
  # the member in.
  #
  # Options:
  # :remember_me - Sets a permanent cookie.
  #
  def login!(member, options = {})
    if options[:remember_me]
      cookies.permanent[:auth_token] = member.auth_token
    else
      cookies[:auth_token] = member.auth_token
    end
  end
  helper_method :login!

  # logout! : -> Boolean
  # Clears the :auth_token from the cookies. If there is not a
  # :auth_token, return false. Otherwise true.
  #
  def logout!
    cookies[:auth_token] ? !cookies[:auth_token] = nil : false
  end
  helper_method :logout!
end
