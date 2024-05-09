class ProductsController < ApplicationController
    def index
        @products = Product.all
        render json: @products, each_serializer: ProductSerializer
    end
end