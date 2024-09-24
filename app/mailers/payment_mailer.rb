class PaymentMailer < ApplicationMailer
  def send_payment_link
	  @payment_url = params[:payment_url]
	  mail(to: params[:email], subject: 'Votre lien de paiement')
  end
end
