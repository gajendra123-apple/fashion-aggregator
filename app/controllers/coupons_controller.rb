class CouponsController < ApplicationController
  include Authentication
  before_action :authenticate_user, only:[:index]

  def index
    @coupons = Coupon.all
    render json: @coupons, each_serializer: CouponSerializer, status: :ok
  end
end