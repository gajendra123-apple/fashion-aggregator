class SubCategoriesController < ApplicationController
    before_action :find_category
    
    def index
      @subcategories = @category.subcategories
      render json: @subcategories, each_serializer: SubcategorySerializer, status: :ok
    end
    
    private
    
    def find_category
      @category = Category.find_by(id: params[:category_id])
      unless @category
        render json: { error: "Category not found" }, status: :not_found
      end
    end
end  