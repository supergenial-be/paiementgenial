class PaymentProcessorJob < ApplicationJob
  queue_as :default

  def perform(registration_id)
    # Fetch inscription details
    notion = NotionClient.new
    registration = notion.get_registration_details(registration_id)

    # Extract participant email and event ID
    participant_email = registration['properties']['E-mail']['email']
    event_id = registration['properties']['(PG) ID de la formation']['relation'][0]['id']

    # Proceed to generate payment link and send email
    PaymentService.new(registration_id, event_id, participant_email).process_payment
  end
end