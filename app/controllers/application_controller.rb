class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  # current_member : -> nil or Member
  # Looks up the current member from the cookies/session :auth_token.
  # The result is cached in the instance variable @current_member.
  #
  def current_member
    if auth_token = session[:auth_token] || cookies[:auth_token]
      key = Key.find_by_token(auth_token)
      @current_member ||= key.keyable if key
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
  # Sets the :auth_token on the cookies/session. Effectively logging
  # the member in.
  #
  # Options:
  # :remember_me - Sets a permanent cookie.
  #
  def login!(member, options = {})
    token = member.authorization_key.token

    session[:auth_token] = token
    if options[:remember_me]
      cookies.permanent[:auth_token] = token
    end
  end
  helper_method :login!

  # logout! : -> Boolean
  # Clears the :auth_token from the cookies/session.
  #
  def logout!
    session[:auth_token] = nil
    cookies[:auth_token] = nil
  end
  helper_method :logout!
end
