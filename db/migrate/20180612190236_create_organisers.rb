class CreateOrganisers < ActiveRecord::Migration[5.2]
  def change
    create_table :organisers do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :salt

      t.timestamps
    end

    create_table :events do |t|
      t.belongs_to :organiser, index: true
      t.string :name
      t.text :description
      t.integer :category
      t.integer :likes
      t.date :day
      t.time :time
      t.string :venue

      t.timestamps
    end
  end
end
