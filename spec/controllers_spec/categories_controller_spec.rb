require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    before do
      create_list(:category, 3)
    end

    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #filter_product_by_category" do
    before do
        @category_men = create(:category, category_type: 'men')
        @subcategory_trouser = create(:Subcategory, name: 'trouser', category: @category_men)
        @product_men = create(:product, category: @category_men, subcategory: @subcategory_trouser)        
    end
    
    it "filters products by men category" do
        get :filter_product_by_category, params: { type: 'men' }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
    end

    it "filters products by men category" do
        get :filter_product_by_category, params: { type: 'women' }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
    end

    it "filters products by men category" do
        get :filter_product_by_category, params: { type: 'kids' }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
    end

    it "returns a success response" do
        get :filter_product_by_category
        expect(response).to have_http_status(:ok)
    end
    
    context "when no products are found" do
        before do
            allow(Product).to receive(:all).and_return([])
        end
        it "returns a 404 status with an error message" do
            get :filter_product_by_category
            expect(response).to have_http_status(:not_found)
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to eq('No products found')
        end
    end
  end
end