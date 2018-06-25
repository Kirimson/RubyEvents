# frozen_string_literal: true

class ApplicationController < ActionController::Base

  def login_needed
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user
  end

  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user = Organiser.find(session[:user_id])
    else
      false
    end
  end

  helper_method :current_user

  def start_session(user)
    session[:user_id] = user.id
  end

  helper_method :start_session

  def event_owner(event)
    return false unless logged_in?
    current_user.id == event.organiser.id
  end

  helper_method :event_owner

end
