class OrdersController < ApplicationController
  include Authentication
  before_action :authenticate_user
  before_action :find_product, only: :buy_now
  before_action :find_cart, only: :placed_order_with_cart

  def buy_now
    @order = current_user.orders.build(order_params)
    @order.total_amount = (@product.price * order_params[:quantity].to_i)
    if @order.save
      render json: @order, status: :created, serializer: OrderSerializer
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def placed_order_with_cart
    @order = current_user.cart.orders.build(order_params)
    @order.update(total_amount: @cart.total_price)
    if @order.save
      render json: @order, status: :created, serializer: OrderSerializer
    else 
      render json: @order.errors, status: :unprocessable_entity
    end
  end 

  private

  def find_product
    begin
      @product = Product.find(params[:order][:product_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Product not found' }, status: :not_found
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def find_cart
    begin
      @cart = Order.find(params[:cart_id])
    rescue ActiveRecord::RecordNotFound
      render json: {error: 'cart not found'}, status: :not_found
    rescue => e
      render json: {error: e.message}, status: :internal_server_error
    end 
  end

  def order_params
    params.require(:order).permit(:order_date, :shipping_address, :billing_address, :product_id, :quantity, :total_amount)
  end
end