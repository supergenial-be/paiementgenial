class CreateEventDatabases < ActiveRecord::Migration[7.2]
  def change
    create_table :event_databases do |t|
      t.string :name
      t.string :notion_database_id
      t.references :notion_workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
