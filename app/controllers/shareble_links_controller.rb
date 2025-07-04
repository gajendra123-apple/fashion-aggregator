class SharebleLinksController < ApplicationController
  # before_action :validate_json_web_token, only: :generate_catalogue_link

  # def generate_catalogue_link
  #   variant = BxBlockCatalogue::CatalogueVariant.find_by(id: params[:id])
  #   if variant
  #     token = request.headers[:token] || params[:token]
  #     # link = "#{request.base_url}//bx_block_deeplinking/deeplink/?link=fashAgg://Productdescription#{variant.id}/"

  #     link = "#{request.base_url}/bx_block_catalogue/share_catalogue_descriptions/#{variant.id}?token=#{token}"
  #     render json: { link: link }, status: :ok
  #   else
  #     render json: { error: 'Variant not found' }, status: :not_found
  #   end
  # end

  # def show
  #   variant = BxBlockCatalogue::CatalogueVariant.find_by(id: params[:id])
  #   if variant.present?
  #     if @token.expiration > Time.now
  #       @data = "fashAgg://Sign_up"
  #       render :view_product_description
  #     else
  #       @data = "fashAgg://Productdescription/#{variant.id}?token=#{@token}"
  #       render :view_product_description
  #     end
  #   else
  #    render json: {errors: "variant not found"},  status: :not_found
  #   end
  # end
end 
  
  
  