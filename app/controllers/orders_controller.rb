class OrdersController < ApplicationController
    before_action :current_user
  
    def index
      @orders = current_user.orders
      render json: @orders, include: :order_items
    end
  
    def show
      @order = current_user.orders.find(params[:id])
      render json: @order, include: :order_items
    end
end
  