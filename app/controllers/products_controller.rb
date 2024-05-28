class ProductsController < ApplicationController
  include Authentication
    before_action :authenticate_user
    before_action :find_product, only:[:sort_product, :filter_product_by_size, :filter_product_by_brand_names,
      :filter_product_by_colors, :filter_product_by_category,:list_of_product_brand_names, :list_of_product_colors, :list_of_product_sizes, :list_of_product_category]

  def index
    page_number = params[:page].to_i
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

  def filter_product_by_size
    case params[:type] 
    when "XS"
      @products = @products.where(size: "XS")
    when "S"
      @products = @products.where(size: "S")
    when "M"
      @products = @products.where(size: "M")
    when "L"
      @products = @products.where(size: "L")
    when "XL"
      @products = @products.where(size: "XL")
    else
      @products = @products.all
    end
    render json: @products, each_serializer: ProductSerializer, status: :ok
  end

  def filter_product_by_brand_names
    brand_names = params[:brand_names]
    if brand_names.present?
      @products = Product.where(brand_name: brand_names)
    else
      @products = Product.all
    end
     render json: @products, each_serializer: ProductSerializer, status: :ok
  end

  def filter_product_by_colors
    colors = params[:colors]
    if colors.present?
      @products = Product.where(color: colors)
    else
      @products = Product.all
    end
    render json: @products, each_serializer: ProductSerializer, status: :ok
  end

  def filter_product_by_category
    case params[:type] 
    when "men"
      @products = @products.joins(:category).where(categories: { category_type: "men"  })
    when "women"
      @products = @products.joins(:category).where(categories: { category_type: "women"  })
    when "kids"
      @products = @products.joins(:category).where(categories: { category_type: "kids"  })
    else
      @products = @products.all
    end
     render json: @products, each_serializer: ProductSerializer, status: :ok
  end

  def list_of_product_brand_names
    @products = @products.pluck(:brand_name)
    render json: { "brand_names" => @products }, status: :ok
  end

  def list_of_product_colors
    @products =@products.pluck(:color)
    render json: { "product_colors" => @products }, status: :ok
  end

  def list_of_product_sizes
    @products = @products.sizes.keys
    render json: { "product_sizes" => @products }, status: :ok
  end

  def list_of_product_category
    @products = @products.joins(:category).pluck('categories.category_type')
    render json: { "product_categories" => @products }, status: :ok
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