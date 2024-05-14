class ReviewsController < ApplicationController
    before_action :current_user

    def add_reviews
        @reviews = @product.reviews.new(review_params)

        Review.new(review_params)
    end


    private

    def product
        @product = Product.find_by(params[:id])
    end

    def review_params
        params.require(:review).permit(:name, :rating, :review_text,product_id)
    end
end