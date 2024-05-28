class CategoriesController < ApplicationController
  include Authentication
    before_action :authenticate_user, only:[:index, :filter_product_by_category]
    before_action :find_product, only:[:filter_product_by_category]

  def index
      @categories = Category.all
      render json: {categories:  @categories}
      # render json: @categories, each_serializer: CategorySerializer
  end 

  def filter_product_by_category
    case params[:type] 
    when "men"
      @products = @products.joins(:category).where(categories: { category_type: "men" })
    when "women"
      @products = Product.joins(:category).where(categories: { category_type: "women" })
    when "kids"
      @products = Product.joins(:category).where(categories: { category_type: "kids" })
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