class AddNotionDatabaseItemIdToRegistrations < ActiveRecord::Migration[7.2]
  def change
    add_column :registrations, :notion_database_item_id, :string
  end
end
