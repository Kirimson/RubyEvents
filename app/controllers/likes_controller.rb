# frozen_string_literal: true

class LikesController < ApplicationController
  def like
    # guard against user already liking event
    @liked = true
    if Like.where(organiser_id: current_user.id).where(
      event_id: params[:like][:event_id]
    ).empty?
      create_like
    else
      delete_like
      @liked = false
    end

    @event = Event.find(params[:like][:event_id])
  end

  def delete_like
    @like = Like.where(organiser_id: current_user.id).where(
      event_id: params[:like][:event_id]
    )
    @like.destroy_all
  end

  def create_like
    @like = Like.new(organiser_id: current_user.id,
                     event_id: params[:like][:event_id])
    @like.save
  end
end
