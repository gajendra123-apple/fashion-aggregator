class ProductsController < ApplicationController
  include Authentication
    before_action :current_user, only:[:index, :sort_product]
    before_action :find_product, only:[:sort_product]

  def index
    page_number = params[:page]
    if page_number.present?
      @products = Product.page(page_number).per(4)
      render json: @products, each_serializer: ProductSerializer
    else
      @products = Product.all
      render json: @products, each_serializer: ProductSerializer
    end
  end
    
  def sort_product
    case params[:type]
    when "highest_to_low"
      @products = @products.order(price: :desc)
    when "lowest_to_high"
      @products = @products.order(price: :asc)
    when "newest"
      @products = @products.order(created_at: :desc)
    when "popular"
      @products =Product.joins(:order_items).group(:product_id).order('count(order_items.id) DESC').all
    else
      @products = @products.all
    end
    render json: @products, each_serializer: ProductSerializer, status: :ok
  end

  private

  def find_product
    @products = Product.all
    if @products.empty?
      render json: { error: 'No products found' }, status: :not_found
      return
    end
  end
end