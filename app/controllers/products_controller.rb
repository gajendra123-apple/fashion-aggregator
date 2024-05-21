class ProductsController < ApplicationController
  include Authentication
   before_action :current_user, only:[:index,  :sort_product, :sort_by_price]

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
      sort_param = params[:type]
      case sort_param
      when 'popularity'
        products = Product.order(popularity: :desc)
      when 'newest'
        products = Product.order(created_at: :desc)
      when 'reviews'
        products = Product.order(average_rating: :desc)
      when 'price_asc'
        products = Product.order(price: :asc)
      when 'price_desc'
        products = Product.order(price: :desc)
      else
        products = Product.all
      end  
      render json: products
  end

  def filter_products
  end

  def sort_by_price
    if params[:type] == "highest_to_low"
      @price = Product.order(price: :desc)
    else #params[:type] == "lowest_to_high"
      @price = Product.order(price: :asc)
    end
      render json: @price, each_serializer: ProductSerializer, status: :ok
  end
end