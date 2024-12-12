class ZylerUserSelfiesController < ApplicationController

        def create_selfies
          user_id = current_user.zyler_user.user_name # user_id and userame is same
          password = current_user.zyler_user.password
          auth = {:username => user_id , :password => password }
          image_data = params[:image]
    
            if image_data.present?
              image_data = Base64.strict_encode64(File.read(image_data.tempfile))
            else
              render json: { errors: 'Image data is empty.' }, status: :bad_request and return
            end
    
          response = HTTParty.post(
            "https://api.zyler.com/v1/users/#{user_id}/selfies",
            basic_auth: auth,
            headers: {
              'accept' => 'application/json',
              'content-type' => 'application/json'
            },
            body: {
              image: image_data
            }.to_json
          )
    
          if response.code == 200
            parsed_response = response.parsed_response
            selfie =create_user_selfie(parsed_response)
            render json: ZylerUserSelfiesSerializer.new(selfie).as_json, status: :ok
            # render json: parsed_response
          else
            render json: { errors: 'Failed to upload selfie.', message: response.body }, status: response.code
          end
        end

        def index
            selfie = ZylerUserSelfie.find_by( zyler_user_id: current_user.zyler_user.id)
      
            if selfie
              render json: ZylerUserSelfiesSerializer.new(selfie).as_json, status: :ok
            else
              render json: { errors: 'Selfie not found.' }, status: :not_found
            end
        end
    
        private
    
        def create_user_selfie(parsed_response)
          result = parsed_response["result"]
        begin
            ZylerUserSelfie.create!(
              zyler_user_id: current_user.zyler_user.id,
              selfie_id: result["id"],                             
              user_id: result["user"]["id"],                       
              head_placement_x: result["headPlacementX"]["value"], 
              head_placement_y: result["headPlacementY"]["value"], 
              head_scale: result["headScale"]["value"],            
              color_correction: result["colorCorrection"],         
              warnings: result["warnings"]                         
            )
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error("Zyler User Selfie creation failed: #{e.message}")
            raise
          end
        end
end
