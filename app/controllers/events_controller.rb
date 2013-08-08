class EventsController < ApplicationController

  # Authenticate logged in member is an officer.
  before_filter :except => [:index, :show] do
    logged_in! :as_officer => true
  end

  def index
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
