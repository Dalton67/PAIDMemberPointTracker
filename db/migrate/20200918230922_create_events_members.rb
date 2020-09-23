class CreateEventsMembers < ActiveRecord::Migration[6.0]
  def up
    create_table :events_members, :id => false do |t|
      t.integer "event_id"
      t.integer "member_id"
    end
    add_index("events_members", ["event_id", "member_id"])
  end

  def down
    drop_table :events_members
  end
end
