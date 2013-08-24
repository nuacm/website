class PagesController < ApplicationController

  def home
    @post = Post.first
    @events = Event.limit(5)
  end

end
