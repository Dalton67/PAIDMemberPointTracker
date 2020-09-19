class CreateEvents < ActiveRecord::Migration[6.0]
  def up
    create_table :events do |t|
      t.string "title"
      t.string "date"
      t.string "semester"
      t.integer "points_worth"
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
