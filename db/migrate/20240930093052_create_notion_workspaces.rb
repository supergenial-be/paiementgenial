class CreateNotionWorkspaces < ActiveRecord::Migration[7.2]
  def change
    create_table :notion_workspaces do |t|
      t.string :name

      t.timestamps
    end
  end
end
