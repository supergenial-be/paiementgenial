class CreateRegistrationDatabases < ActiveRecord::Migration[7.2]
  def change
    create_table :registration_databases do |t|
      t.string :name
      t.string :notion_database_id
      t.references :notion_workspace, null: false, foreign_key: true
      t.references :event_database, null: false, foreign_key: true

      t.timestamps
    end
  end
end
