class AddFromEmailAndFromNameToNotionWorkspaces < ActiveRecord::Migration[7.2]
  def change
    add_column :notion_workspaces, :from_email, :string
    add_column :notion_workspaces, :from_name, :string
  end
end
