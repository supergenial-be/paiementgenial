module Registrations
  class CreateService < ServiceBase
    attr_reader :registration

    def initialize
      @registration = Registration.new
      @report_errors = true
    end

    def run(params = {})
      context = {
        params: params,
      }

      catch_error(context: context) do
        run!(params)
      end
    end

    def run!(params = {})
      registration.attributes = registration_params(params)
      registration.set_registration_database_id
      registration.save!
      true
    end

    private

    def registration_params(params)
      params
        .require(:registration)
        .permit(
          :firstname,
          :lastname,
          :email,
          :phone,
          :amount_cents,
          :payment_status,
          :status,
          :notion_database_item_id,
          :notion_event_id,
          :notion_registration_database_id
        )
    end
  end
end
