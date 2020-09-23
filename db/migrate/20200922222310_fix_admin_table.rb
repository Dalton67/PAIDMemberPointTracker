class FixAdminTable < ActiveRecord::Migration[6.0]
  def up
    remove_column :admin_users, :string
  end
end
