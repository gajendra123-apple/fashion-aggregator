class CartItemsController < ApplicationController
  include Authentication

  def add_product
    byebug  
    @product = Product.find_by(id: params[:product_id])
    unless @product
      return render json: { error: 'Product not found' }, status: :not_found
    end
    @cart = current_user.cart || current_user.build_cart
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: @product.id)

    if @cart_item.persisted?
      render json: { message: "Product is already in the cart" }, status: :ok
    else
      if @cart_item.save
        render json: { message: "Product added to cart successfully" }, status: :created
      else
        render json: { error: 'Failed to add product to cart' }, status: :unprocessable_entity
      end
    end
  end

  def remove_product
    byebug
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    
    unless @cart_item
      return render json: { error: 'Product not found in cart' }, status: :not_found
    end
    
    if @cart_item.destroy
      render json: { message: "Product removed from cart successfully" }, status: :ok
    else
      render json: { error: 'Failed to remove product from cart' }, status: :unprocessable_entity
    end
  end

end