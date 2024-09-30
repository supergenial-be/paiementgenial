# == Schema Information
#
# Table name: event_databases
#
#  id                  :bigint           not null, primary key
#  name                :string
#  notion_database_id  :string
#  notion_workspace_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class EventDatabase < ApplicationRecord
  belongs_to :notion_workspace
end
