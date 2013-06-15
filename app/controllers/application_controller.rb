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

  # logged_in? : options -> Boolean
  # Checks if there is a logged in member. Options provide more
  # checks.
  #
  # :as_member => Member    - Checks if the current user is the given user.
  # :as_officer => Boolean  - Checks if the current user is an Officer.
  #
  def logged_in?(options = {})
    # options = { options => true } if options.is_a?(Symbol)

    result = if options[:as_officer]
      current_member.is_a?(Officer)
    end
    result ||= if options[:as_member]
      current_member == options[:as_member]
    end
    result ||= if options.empty?
      !current_member.nil?
    end
  end
  helper_method :logged_in?

  # logged_in! : options -> Boolean
  # Checks if there is a logged in member. Options provide more
  # checks. If checks do not pass, redirects to home page.
  #
  # :as_member => Member    - Checks if the current user is the given user.
  # :as_officer => Boolean  - Checks if the current user is an Officer.
  #
  def logged_in!(options = {})
    unless logged_in?(options)
      redirect_to home_path, :alert => "Not authorized."
    end
  end
  helper_method :logged_in!

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
