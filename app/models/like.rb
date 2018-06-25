class Like < ApplicationRecord
  has_one :organiser
  has_one :event

  after_save :like_event
  before_destroy :unlike_event

  def like_event
    @event = Event.find(event_id)
    @event.likes += 1
    @event.save
  end

  def unlike_event
    @event = Event.find(event_id)
    @event.likes -= 1
    @event.save
  end
end
