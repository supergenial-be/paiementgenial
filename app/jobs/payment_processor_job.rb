class PaymentProcessorJob < ApplicationJob
  queue_as :default

  def perform(registration_id)
    # Fetch inscription details
    notion = NotionClient.new
    registration = Registration.find(registration_id)
    # registration = notion.get_registration_details(registration_id)

    # Extract participant email and event ID
    # participant_email = registration['properties']['E-mail']['email']
    # event_id = registration['properties']['(PG) ID de la formation']['relation'][0]['id']

    # Proceed to generate payment link and send email
    PaymentService.new(registration_id).process_payment
  end
end