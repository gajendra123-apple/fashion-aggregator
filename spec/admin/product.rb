require 'rails_helper'
require 'spec_helper'
require 'devise'

RSpec.describe Admin::ProductsController, type: :controller do
  render_views
  before(:each) do
    byebug
    @admin = FactoryBot.create(:admin_user)
    #@admin = AdminUser.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password')
    byebug
    sign_in @admin
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index    
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
end