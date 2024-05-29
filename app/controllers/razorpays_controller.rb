require 'razorpay'
require 'dotenv/load'
class RazorpaysController < ApplicationController
  include Authentication
  before_action :authenticate_user
  # skip_before_action :verify_authenticity_token, only: [:capture_payment]

  def create_razorpay_order
  	amount = params[:amount].to_i
    para_attr ={
    	"amount": amount*100,
    	"currency": "INR",
    	"receipt": "receipt#1"
    }
    order = Razorpay::Order.create(para_attr) unless Rails.env.test?
    if order&.status == 'created'
    	razorpay_order = create_order(order)
      render json: RazorpayOrderSerializer.new(razorpay_order).as_json, status: 201
    else
    	render json: {message: "Faild to create order! please retry"}, status: :unprocessable_entity
    end 
  end

  def capture_payment
    payment_id = params[:razorpay_payment_id]
    order_id = params[:razorpay_order_id]
    signature = params[:razorpay_signature]

    unless verify_signature(payment_id, order_id, signature)
      render json: { message: 'Signature verification failed' }, status: :unprocessable_entity
      return
    end

    begin
      payment = Razorpay::Payment.fetch(payment_id)
      if payment.status == 'captured'
        render json: { message: 'Payment successful' }, status: :ok
      else
        render json: { message: 'Payment capture failed' }, status: :unprocessable_entity
      end
    rescue Razorpay::Error => e
      render json: { message: e.message }, status: :unprocessable_entity
    end #1
  end

  # def capture_payment
  #   payment_id = params[:razorpay_payment_id]
  #   amount_in_rupees = params[:amount].to_i
  #   amount_in_paise = amount_in_rupees * 100

	#   para_attr = {
	#     amount: amount_in_paise,
	#     currency: "INR"
	#   }
  #   begin
  #    payment = Razorpay::Payment.capture(payment_id,para_attr)
  #    byebug
	# 	if payment.status == 'captured'
  #       render json: { message: 'Payment successful' }, status: :ok
  #     else
  #       render json: { message: 'Payment capture failed' }, status: :unprocessable_entity
  #     end
  #   rescue Razorpay::BadRequestError => e
  #     Rails.logger.error "Authentication failed: #{e.message}"
  #     render json: { message: 'Authentication failed', error: e.message }, status: :unauthorized
  #   rescue Razorpay::Error => e
  #     render json: { message: e.message }, status: :unprocessable_entity
  #   end
  # end

  private

  def verify_signature(payment_id, order_id, signature)
    secret = "1ZPDPeytB0A2FhJgvxze1unr"
    body = "#{order_id}|#{payment_id}"
    expected_signature = OpenSSL::HMAC.hexdigest('sha256', secret, body)
    expected_signature == signature
  end

  def create_order(order) #working
  	RazorpayOrder.create(
  		amount: (order.amount/100),
  		status: order.status,
  		user_id: current_user.id,
  		receipt: order.receipt,
  		currency: order.currency,
  		order_id: order.id
  	)
  end
end
