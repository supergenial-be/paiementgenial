class PaymentService
  def initialize(registration_id, event_id, participant_email)
    @registration_id = registration_id
    @event_id = event_id
    @participant_email = participant_email
    @notion = NotionClient.new
  end

  def process_payment
    # Get event details
    event = @notion.get_event_details(@event_id)
    price = event['properties']['(PG) Tarif']['number']
    available_tickets = event['properties']['(PG) Tickets']['number']

    # Create a Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: event['properties']['Name']['title'][0]['text']['content'],
        amount: (price * 100).to_i, # Stripe expects amount in cents
        currency: 'eur',
        quantity: 1
      }],
      metadata: {
        registration_id: @registration_id
      },
      success_url: 'https://pg.supergenial.be/payments/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://pg.supergenial.be/payments/cancel'
    )

    # Send payment link via email
    PaymentMailer.with(email: @participant_email, payment_url: session.url).send_payment_link.deliver_now

    # Update payment status to 'En cours'
    @notion.update_registration(@registration_id, {
      "(PG) Statut du paiement": { select: { name: 'En cours' } }
    })
  end
end
