# == Schema Information
#
# Table name: registration_databases
#
#  id                  :bigint           not null, primary key
#  name                :string
#  notion_database_id  :string
#  notion_workspace_id :bigint           not null
#  event_database_id   :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class RegistrationDatabase < ApplicationRecord
  belongs_to :notion_workspace
  belongs_to :event_database
end
