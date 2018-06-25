class CreateRelatedEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :related_events do |t|
      t.integer :event_id
      t.integer :related_event_id
      t.timestamps
    end
  end
end
