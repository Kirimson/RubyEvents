class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :organiser, index: true
      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
