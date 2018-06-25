# frozen_string_literal: true

require 'digest/sha1'
class OrganiserController < ApplicationController
  def show
    @organiser = Organiser.find(params[:id])
    @page = "User|#{@organiser.uc_name}"
  end

  def login
    @page = 'User|Login'
    redirect_to current_user if logged_in?
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def verify
    user = Organiser.find_by_email(params[:session][:email])
    if user&.password_correct?(params[:session][:password])
      start_session user
      redirect_to user
    else
      render 'login'
    end
  end

  def index
    @page = 'User|Home'
    @organisers = Organiser.all
  end

  def new
    @page = 'User|Register'
    @user = Organiser.new
  end

  def create
    @page = 'User|Register'
    @user = Organiser.new(organiser_params)
    if @user.save
      start_session @user
      redirect_to @user
    else
      redirect_to '/organiser/new', flash: { error: @user.errors.full_messages }
    end
  end

  def organiser_params
    params.require(:organiser).permit(:name, :email, :email_confirmation, :password, :password_confirmation)
  end
end
