class Event < ApplicationRecord

  belongs_to :organiser
  has_many :related_events
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :day, presence: true
  validates :time, presence: true
  validates :venue, presence: true
  enum category: [ :Sport, :Culture, :Other ]

  def short_description
    short = description
    good_para = false
    max_length = 160

    # if short has a paragraph
    while !good_para && short.include?('<p>')
      start_pos = short.index('<p>')
      end_pos = short.index('</p>')
      paragraph = short[start_pos..end_pos + 3]

      if paragraph.include?('<img')
        good_para = false
        short = short[end_pos + 4..-1]
      else
        # found good para
        paragraph = paragraph.length > max_length ? paragraph[0..max_length] + '...' : paragraph
        return paragraph
      end
    end
    'No description available'
  end

  def readable_date
    day_string = day.strftime("%A the #{day.day.ordinalize} of %B ")
    time_string = time.strftime('at %I:%M%P')
    day_string + time_string
  end

  def image_url
    image.attachment ? image : 'event.png'
  end

  def related_events
    ids = RelatedEvent.where(event_id: id).pluck(:related_event_id)
    return nil unless ids
    Event.find(ids)
  end

  def related_to?(event_id)
    RelatedEvent.where(event_id: id).pluck(:related_event_id).include?(event_id)
  end

  def related_events?
    true
  end

  def not_new?
    true if id
  end
end
