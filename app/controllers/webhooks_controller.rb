class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new_registration
    # registration_id = params[:notion_registration_id]
    service = Registrations::CreateService.new
    if service.run(params)
      PaymentProcessorJob.perform_later(service.registration&.id)
      head :ok
    else
      head :bad_request
    end
  end

  def stripe
    ap "Hey, Stripe here !"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError => e
      # Invalid payload
      head :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      head :bad_request
      return
    end

    # Handle the event
    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']
      handle_successful_payment(session)
    end

    head :ok
  end

  private

  def handle_successful_payment(session)
    ap "Handle successful payment"
    registration_id = session.metadata.registration_id
    notion = NotionClient.new

    # Update payment status to 'Payé'
    registration = Registration.find(registration_id)
    registration.update(payment_status: "Payé")
    notion.update_registration(
      registration.notion_database_item_id, 
      {
        "(PG) Statut du paiement": { select: { name: 'Payé' } }
      }
    )

    # TODO - Optionally, update available tickets
    # event_id = ... # Retrieve event ID associated with the inscription
    update_available_tickets(registration.notion_event_id)
  end

  def update_available_tickets(event_id)
    ap "Update available tickets (#{event_id})"
    notion = NotionClient.new
    event = notion.get_event_details(event_id)
    byebug
    available_tickets = event['properties']['(PG) Tickets']['number']

    # Decrement the number of tickets by 1
    new_ticket_count = available_tickets - 1

    if new_ticket_count <= 0
      notion.update_event(event_id, {
        "(PG) Mode": { select: { name: 'Inscriptions closes' } }
      })
    end

    notion.update_event(event_id, {
      "(PG) Tickets": { number: new_ticket_count }
    })
  end
end