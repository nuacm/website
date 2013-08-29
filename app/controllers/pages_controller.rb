class PagesController < ApplicationController

  def home
    @post = Post.first
    @events = Event.upcoming.limit(3)
  end

end
