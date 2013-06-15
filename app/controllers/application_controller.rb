class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # current_member : -> nil or Member
  # Looks up the current member from the session :member_id.
  # The result is cached in the instance variable @current_member.
  #
  def current_member
    @current_member ||= Member.find(session[:member_id]) if session[:member_id]
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

  # login! : -> Boolean
  # Sets the :member_id on the session. Effectively logging
  # the member in.
  #
  def login!(member)
    session[:member_id] = member.id
  end
  helper_method :login!

  # logout! : -> Boolean
  # Clears the :member_id from the session. If there is not a
  # :member_id, return false. Otherwise true.
  #
  def logout!
    session[:member_id] ? !session[:member_id] = nil : false
  end
  helper_method :logout!
end
