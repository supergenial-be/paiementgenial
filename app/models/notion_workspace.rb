class NotionWorkspace < ApplicationRecord
  has_many :event_databases
  has_many :registration_databases
end