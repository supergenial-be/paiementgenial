class PaymentService
  def initialize(registration_id)
    @registration = Registration.find(registration_id)
    @notion = NotionClient.new
  end

  def process_payment
    # Get event details
    event = @notion.get_event_details(@registration.notion_event_id)
    price = event['properties']['(PG) Tarif']['number']
    available_tickets = event['properties']['(PG) Tickets']['number']

    session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: 'eur',
          unit_amount: (price * 100).to_i,
          product_data: {
            name: event['properties']['Name']['title'][0]['text']['content'],
            description: "Frais d'inscription"
          },
        },
        quantity: 1
      }],
      client_reference_id: @registration.id,
      customer_email: @registration.email,
      mode: "payment",
      success_url: 'https://pg.supergenial.be/payments/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://pg.supergenial.be/payments/cancel',
      metadata: {
        registration_id: @registration.id
      }
    )

    # Send payment link via email
    ap session.url
    PaymentMailer.with(
        from: @registration.registration_database.notion_workspace.from_email,
        email: @registration.email,
        payment_url: session.url
      ).send_payment_link.deliver_now

    # Update payment status to 'En cours'
    @registration.update(payment_status: "En cours")
    # TODO updating the registration should trigger an update of the Notion record
    # @notion.update_registration(@registration.id, {
    #   "(PG) Statut du paiement": { select: { name: 'En cours' } }
    # })
  end
end
