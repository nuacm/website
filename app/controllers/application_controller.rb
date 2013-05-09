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

  # authorize : options -> Boolean
  # :is      - Checks if the current user is the given user.
  # :any     - Checks if there is a current user.
  # :officer - Checks if the current user is an Officer.
  #
  def authorize(options = {})
    options = { options => true } if options.is_a?(Symbol)

    result = if options[:officer]
      current_member.is_a?(Officer)
    end
    result ||= if options[:is]
      current_member == options[:is]
    end
    result ||= if options[:any]
      !current_member.nil?
    end
  end
  helper_method :authorize

  # authorize!
  # :is      - Checks if the current user is the given user.
  # :any     - Checks if there is a current user.
  # :officer - Checks if the current user is an Officer.
  # If authorize is false redirect home and alert the user.
  #
  def authorize!(options = {})
    redirect_to home_path, :alert => "Not authorized." unless authorize(options)
  end
  helper_method :authorize!

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
