class AddNotionRegistrationDatabaseIdToRegistrations < ActiveRecord::Migration[7.2]
  def change
    add_column :registrations, :notion_registration_database_id, :string
  end
end
