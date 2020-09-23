class CreateAdminUsersTable < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_users do |t|
      t.string "first_name", limit: 25
      t.string "last_name", limit: 50
      t.string "email", limit: 100, default: "", null: false
      t.string "username", limit: 25
      t.string "password_digest" 
      t.datetime "created_at", null:false
      t.datetime "updated_at", null:false
      t.index ["username"], name: "index_admin"
    end
  end

  def down
    drop_table :admin_users
  end
end
