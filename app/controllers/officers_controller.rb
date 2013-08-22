class OfficersController < ApplicationController

  def index
    @officers = Officer.all
  end

end
