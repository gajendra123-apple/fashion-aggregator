class CartsController < ApplicationController
  include Authentication
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_product, :remove_product, :apply_coupon]

  def show
    @cart
    render json: @cart, serializer: CartSerializer, status: :ok
  end

  def add_product
    product_id = params[:product_id].to_i
    quantity = params[:quantity].presence || 1
    @cart.add_product(product_id, quantity)
    if @cart.save       
      cart_data = ActiveModelSerializers::SerializableResource.new(@cart, serializer: CartSerializer).as_json
      render json: cart_data.merge(message: "Product added to cart successfully"), status: :ok 
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end
  
  def remove_product
    cart_item_id = params[:cart_item_id].to_i
    cart_item = current_user.cart.cart_items.find_by(id: cart_item_id)
    if cart_item
      cart_item.quantity -= 1
      if cart_item.quantity <= 0
        cart_item.destroy
      else
        cart_item.save
      end
      @cart.recalculate_total_with_coupon
      render json: { message: "Product has been removed from the cart", total_price: @cart.total_price }, status: :ok

    else
      render json: { error: "Product not found in the cart" }, status: :not_found
    end
  end

  def apply_coupon
    if @cart.apply_coupon(params[:coupon_code])
      render json: { message: "Coupon applied successfully", cart: @cart }, status: :ok
    else
      render json: {error: "coupon not found"}, status: :unprocessable_entity
      # render json: { error: @cart.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
  
  private
  
  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized, please login' }, status: :unauthorized
    end
  end

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  # def recalculate_total_with_coupon
  #   total_without_coupon = @cart.cart_items.joins(:product).sum('cart_items.quantity * products.price')
  # end
end