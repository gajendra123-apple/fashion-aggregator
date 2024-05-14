class CartItemsController < ApplicationController
    before_action :authenticate_user

    def add_product
        @product = Product.find(params[:product_id])
        @cart = current_user.cart || current_user.build_cart
        @cart_item = @cart.cart_items.find_or_initialize_by(product_id: @product.id)
        @cart_item.quantity ||= 0
        @cart_item.quantity += 1
        if @cart_item.save
          render json: { message: "Product added to cart successfully" }, status: :created
        else
          render json: { error: 'Failed to add product to cart' }, status: :unprocessable_entity
        end
    end

    def remove_product
      @cart = current_user.cart
      @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    
      unless @cart_item.present?
        return render json: { error: 'Product not found in cart' }, status: :not_found
      end
    
      if @cart_item.destroy
        render json: { message: "Product removed from cart successfully" }, status: :ok
      else
        render json: { error: 'Failed to remove product from cart' }, status: :unprocessable_entity
      end
    end
    

    private

    def authenticate_user
        @current_user = current_user
        render json: { error: 'Unauthorized user' }, status: :unauthorized unless @current_user
    end
end