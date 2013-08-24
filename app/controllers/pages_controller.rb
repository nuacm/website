class PagesController < ApplicationController

  def home
    @post = Post.first
    @events = Event.all(:limit => 5)
  end

end
