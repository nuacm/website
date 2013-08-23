class EventsController < ApplicationController

  # Set the @event for all actions that expect an event to
  # already exist.
  before_filter :except => [:index, :new, :create] do
    @event = Event.find(params[:id])
  end

  # Authenticate logged in member is an officer.
  before_filter :except => [:index, :show] do
    logged_in! :as_officer => true
  end

  def index
    @events = Event.all
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
