# == Schema Information
#
# Table name: notion_workspaces
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from_email :string
#  from_name  :string
#
class NotionWorkspace < ApplicationRecord
  has_many :event_databases
  has_many :registration_databases
end
