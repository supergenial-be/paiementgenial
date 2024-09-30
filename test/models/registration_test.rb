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
require "test_helper"

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
