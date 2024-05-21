class BrandsController < ApplicationController
    def index
        @brands = Brand.all
        render json: {:brands  @brands}
    end
end