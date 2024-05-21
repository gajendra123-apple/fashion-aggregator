class CartsController < ApplicationController
  include Authentication
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_product, :remove_product, :apply_coupon, :checkout]

  def show
    render json: @cart, include: :cart_items
  end

  def add_product
    @cart.add_product(params[:product_id], params[:quantity].to_i)
    if @cart.save
      render json: { message: "Product added to cart successfully", cart: @cart }, status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def remove_product
    product_removed = @cart.remove_product(params[:product_id])
    if product_removed
      render json: { message: "Product has been removed from the cart" }, status: :ok
    else
      render json: { error: "Product not found in the cart" }, status: :not_found
    end
  end

  def apply_coupon
    if @cart.apply_coupon(params[:coupon_code])
      render json: { message: "Coupon applied successfully", cart: @cart }, status: :ok
    else
      render json: { error: "Invalid coupon code or unable to apply coupon" }, status: :unprocessable_entity
    end
  end

  def checkout
    order = current_user.orders.build
    if order.create_from_cart(@cart)
      render json: { message: "Checkout successful", order: order }, status: :ok
    else
      render json: order.errors, status: :unprocessable_entity
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
end
