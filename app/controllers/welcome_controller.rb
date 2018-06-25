class WelcomeController < ApplicationController
  def index
    @page = 'Home|Home'
    @events = Event.all
  end
end
