require 'rails_helper'

RSpec.describe SubCategoriesController, type: :controller do
  describe 'GET #index' do
    before do
        create_list() {create(:category)}
        create_list() {create(:Subcategory, category: category.id)}
    end
    context 'when category exists' do
      it 'returns a successful response' do
        get :index, params: { category_id: category.id }
        byebug
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).first['id']).to eq(sub_category.id)
      end
    end

    context 'when category does not exist' do
      it 'returns a not found response' do
        get :index, params: { category_id: 0 } # Assuming 0 is an ID that does not exist
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Category not found')
      end
    end
  end
end