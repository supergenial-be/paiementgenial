# == Schema Information
#
# Table name: registrations
#
#  registration_database_id        :bigint           not null
#  firstname                       :string
#  lastname                        :string
#  email                           :string
#  phone                           :string
#  notion_event_id                 :string
#  amount_cents                    :integer
#  payment_status                  :string
#  status                          :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  notion_database_item_id         :string
#  notion_registration_database_id :string
#  id                              :uuid             not null, primary key
#
class Registration < ApplicationRecord
  belongs_to :registration_database

  def set_registration_database_id
    self.registration_database = RegistrationDatabase.where(
        notion_database_id: self.notion_registration_database_id.delete('-')
      )&.first
  end
end
