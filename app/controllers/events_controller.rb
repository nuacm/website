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
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = Event.new
    render :edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, :notice => "Created event."
    else
      render :edit
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to @event, :notice => "Updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, :notice => "Event deleted successfully."
  end

  private

  # Requires
  # * `:event`
  # Permits
  # * `:title`
  # * `:location`
  # * `:start_time`
  # * `:end_time`
  # * `:description`
  #
  def event_params
    params.require(:event).permit :title,
                                  :location,
                                  :start_time,
                                  :end_time,
                                  :description
  end
end
