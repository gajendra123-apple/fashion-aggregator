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
      params.require(:review).permit(:rating, :review_text,product_id)
  end

  def customer_review
    @review =Review.order(rating: :desc)
    render json: @review, each_serializer: ReviewSerializer, status: :ok
  end
end