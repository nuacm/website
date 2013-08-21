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

  def get_bigpic
    pool = [
      'https://farm9.staticflickr.com/8323/8429149142_04932dfa25_k.jpg',
      'http://farm6.staticflickr.com/5538/9145652131_e87e9e4bf3_k.jpg',
      'http://farm9.staticflickr.com/8054/8429138978_98e1d89081_k.jpg',
      'http://farm9.staticflickr.com/8096/8428048907_cb647a407a_k.jpg',
      'http://farm9.staticflickr.com/8185/8429149728_0020113ebf_k.jpg',
      'http://farm9.staticflickr.com/8376/8428058045_ca1ca3bcb1_k.jpg',
      'http://farm9.staticflickr.com/8044/8428059529_7e5959ebee_k.jpg',
      'http://farm9.staticflickr.com/8366/8428064063_55c9ed2e2e_k.jpg'
    ]
    return pool.sample
  end
  helper_method :get_bigpic

end
