# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.string 'email'
      t.integer 'fall_points'
      t.integer 'spring_points'
      t.integer 'total_points'
      t.timestamps
    end
  end

  def down
    drop_table :members
  end
end
