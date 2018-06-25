# frozen_string_literal: true

# Provides interface for event functionality
class EventsController < ApplicationController
  def index
    @page = 'Events|Events'
    @events = Event.all
  end

  def new
    @page = 'Events|Create Event'
    @event = Event.new
    @events = all_events
    redirect_to login_path unless logged_in?
  end

  def create
    @page = 'Events|Create Event'
    @event = Event.new(event_params)
    related_ids = params[:event][:related_event][1..-1]
    check_relations(@event.id, related_ids) if attempt_save(@event)
  end

  def show
    @event = Event.find(params[:id])
    @page = "Events|#{@event.name}"
    @liked = event_liked params[:id]
  end

  def edit
    @event = Event.find(params[:id])
    @page = "Events|Editing #{@event.name}"
    @events = all_events_but(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    related_ids = params[:event][:related_event][1..-1]
    check_relations(params[:id], related_ids) if attempt_update(@event)
  end

  def event_liked(id)
    return false unless logged_in?
    return false if Like.where(organiser_id: current_user.id).where(
      event_id: id
    ).empty?
    true
  end

  private

  def event_params
    params[:event][:organiser_id] = current_user.id
    params[:event][:likes] = 0
    params.require(:event).permit(:name, :description, :day, :time, :venue,
                                  :category, :organiser_id, :likes, :image)
  end

  def all_events
    Event.all
  end

  def all_events_but(id)
    Event.where.not(id: id)
  end

  def check_relations(event_id, related_ids)
    related_ids = related_ids.map(&:to_i)
    # for each relation, check if they exist
    create_relations(event_id, related_ids)
    # check that relation still exists
    delete_relations(event_id, related_ids)
  end

  def create_relations(event_id, related_ids)
    related_ids.each do |relation|
      # only if relation does not exist
      if get_relation(event_id, relation).empty?
        RelatedEvent.create!(event_id: event_id, related_event_id: relation)
      end
    end
  end

  def delete_relations(event_id, related_ids)
    Event.find(event_id).related_events.each do |related_event|
      next if related_ids.include?(related_event.id)
      relation = get_relation(event_id, related_event.id)
      relation.destroy_all
    end
  end

  def get_relation(event_id, related_id)
    RelatedEvent.where(event_id: event_id).where(related_event_id: related_id)
  end

  def event_errors(event)
    event.errors.full_messages
  end

  def attempt_update(event)
    if event.update(event_params)
      redirect_to event
    else
      redirect_to "events/#{event.id}/edit",
                  flash: { error: event_errors(event) }
      false
    end
  end

  def attempt_save(event)
    if event.save
      redirect_to event
    else
      redirect_to '/events/new',
                  flash: { error: event_errors(event) }
      false
    end
  end
end
