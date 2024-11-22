class ReviewsController < ApplicationController
    include Authentication
    before_action :authenticate_user
    before_action :find_product, only:[:add_reviews, :customer_review]

    def add_reviews
      @review = @product.reviews.new(review_params.merge(user_id: current_user.id))
      if @review.save
        render json: { review: @review }, status: :created
      else
        render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def customer_review
      @review =Review.order(rating: :desc)
      render json: @review, each_serializer: ReviewSerializer, status: :ok
    end
  
    private

    def find_product
      @product = Product.find_by(id: params[:review][:product_id])
      unless @product
        render json: { error: "Product not found" }, status: :not_found
      end
    end
  
    def review_params
      params.require(:review).permit(:rating, :review_text, :product_id,  current_user.id)
    end
end