class AddAmountToItems < ActiveRecord::Migration[6.0]
  def change
        # add_column table_name, :column_name, :column_type
        add_column :events, :mapped_id, :integer
  end
end
