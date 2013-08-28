class PagesController < ApplicationController

  def home
    @post = Post.first
    @events = Event.upcoming.limit(5)
  end

end
