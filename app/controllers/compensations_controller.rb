# Stripe Docu here: https://stripe.com/docs/payments/payment-intents

class CompensationsController < ApplicationController
  def new
    @compensation = Compensation.new

    calculation_id = params[:calculation_id].to_i
    @calculation = Calculation.find(calculation_id)


    #Defining the prices for the frontend
    @SAF_price_in_EUR = @calculation.SAF_price_in_EUR
    @SAF_price_in_cents = (@SAF_price_in_EUR * 100).to_i


    @GFC_operational_fee_in_cents = (@SAF_price_in_cents / 10).to_i
    @GFC_operational_fee_in_EUR = @GFC_operational_fee_in_cents.to_f / 100

    @total_payable_price_in_cents = @SAF_price_in_cents + @GFC_operational_fee_in_cents
    @total_payable_price_in_EUR = @total_payable_price_in_cents.to_f / 100

    # add intent
    @intent = Stripe::PaymentIntent.create(
      amount: @total_payable_price_in_cents,
      currency: 'eur',
      payment_method_types: ['card'],
    )
  end

  def create
  end

end
