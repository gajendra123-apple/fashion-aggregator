require 'rails_helper'
RSpec.describe CartsController, type: :controller do

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:subcategory) { create(:subcategory) }
  let!(:product1) { create(:product, subcategory: subcategory) }
  let(:cart) { create(:cart, user: user1) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product1, quantity: 1) }

  before do
    allow(controller).to receive(:current_user).and_return(user1)
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: {id: cart.id}
      expect(response).to have_http_status(:ok)
    end
  end

  # describe "POST #add_product" do
  #   context "with valid parameters" do
  #     it "adds a product to the cart" do
  #       post :add_product, params: { product_id: products.first.id, quantity: 1 }
  #       expect(response).to have_http_status(:ok)
  #       json_response = JSON.parse(response.body)
  #       expect(json_response['message']).to eq("Product added to cart successfully")
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "returns an error" do
  #       post :add_product, params: { product_id: nil, quantity: 1 }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe "DELETE #remove_product" do
  #   context "when the product is in the cart" do
  #     before do
  #       cart_item
  #     end

  #     it "removes the product from the cart" do
  #       delete :remove_product, params: { cart_item_id: cart_item.id }
  #       expect(response).to have_http_status(:ok)
  #       json_response = JSON.parse(response.body)
  #       expect(json_response['message']).to eq("Product has been removed from the cart")
  #     end
  #   end

  #   context "when the product is not in the cart" do
  #     it "returns an error" do
  #       delete :remove_product, params: { cart_item_id: -1 }
  #       expect(response).to have_http_status(:not_found)
  #       json_response = JSON.parse(response.body)
  #       expect(json_response['error']).to eq("Product not found in the cart")
  #     end
  #   end
  # end

  # describe "POST #apply_coupon" do
  #   # let(:coupon) { create(:coupon) }

  #   context "with a valid coupon" do
  #     it "applies the coupon to the cart" do
  #       post :apply_coupon, params: { coupon_code: coupon.code }
  #       expect(response).to have_http_status(:ok)
  #       json_response = JSON.parse(response.body)
  #       expect(json_response['message']).to eq("Coupon applied successfully")
  #     end
  #   end

  #   context "with an invalid coupon" do
  #     it "returns an error" do
  #       post :apply_coupon, params: { coupon_code: 'invalid' }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       json_response = JSON.parse(response.body)
  #       expect(json_response['error']).to eq("coupon not found")
  #     end
  #   end
  # end
end
