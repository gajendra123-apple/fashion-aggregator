class ZylerUsersController < ApplicationController
    def create
        user = current_user
        service = AiVirtualMannequinService.new(user)

        begin
        zyler_user = service.create_zyler_user
        render json: AiVirtualMannequinSerializer.new(zyler_user).as_json, status: :ok
        rescue StandardError => e
        render json: { errors: 'Failed record creation.', message: e.message }, status: :unprocessable_entity
        end
    end
    
        # def create #new working
        #   user = current_user
        #   response = HTTParty.post('https://api.zyler.com/v1/users',
        #     headers: {
        #       'Accept' => 'application/json',
        #       'Content-Type' => 'application/json'
        #     },
        #     body: {
        #       email: user.email,
        #       privacyPolicyConfirmed: true,
        #       partnerTermsConfirmed: true
        #     }.to_json
        #   )
        #   if response.code == 200
        #     parsed_response = response.parsed_response
        #     zyler_user = create_zyler_user(parsed_response)
        #     render json: BxBlockCatalogue::AiVirtualMannequinSerializer.new(zyler_user).as_json, status: :ok
        #   else
        #     error_details = JSON.parse(response.body)["status"]
        #     render json: { errors: 'Failed record creation.', 
        #                    message: error_details["errorMessage"]
        #                 }, status: :unprocessable_entity  
        #   end
        # end
    
        # def update
        #   userId = "uu0c454d5fc501b167c2625fdd"
        #   auth = {:username => "uu0c454d5fc501b167c2625fdd", :password => "c9e89f2d717e9763a3b035482c311d8b"}
        #   response = HTTParty.post("https://api.zyler.com/v1/users/#{userId}", :basic_auth => auth,
        #     headers: {
        #       'Accept' => 'application/json',
        #       'Content-Type' => 'application/json'
        #     },
        #     body: {
        #       # email: current_user.email 
        #       # email: "gajairq7@gmail.com",
        #       privacyPolicyConfirmed: true,
        #       partnerTermsConfirmed: true,
        #       firstName: "gajendra"
        #     }.to_json
        #   )
        #   if response.code == 200
        #      parsed_response = response.parsed_response
        #     # create_zyler_user(parsed_response)
        #     # parsed_response["result"]["privacyPolicyConfirmed"] = true
        #     render json: parsed_response
        #   else
        #    render json: { errors: 'faild record creation.' }
        #   end
        # end
        
        # def update
        #   userId = "uu0c454d5fc501b167c2625fdd"
        #   auth = {:username => "uu0c454d5fc501b167c2625fdd", :password => "c9e89f2d717e9763a3b035482c311d8b"}
        #   measurements = params[:measurements].to_unsafe_h
        #   response = HTTParty.post(
        #     "https://api.zyler.com/v1/users/#{userId}", :basic_auth => auth,
        #     headers: {
        #       'accept' => 'application/json',
        #       'content-type' => 'application/json'
        #     },
        #     body: {
        #       privacyPolicyConfirmed: true,
        #       measurements: measurements
        #     }.to_json
        #   )
    
        #   if response.code == 200
        #     parsed_response = parse_json_strings(response.parsed_response)
        #     render json: parsed_response
        #   else
        #    render json: { errors: 'faild record creation.' }
        #   end
        # end
    
        # def create #create selfies
        #   user_id = "uu0c454d5fc501b167c2625fdd" 
        #   auth = {:username => "uu0c454d5fc501b167c2625fdd", :password => "c9e89f2d717e9763a3b035482c311d8b"}
        #   image_data = params[:image]
    
        #     if image_data.present?
        #       image_data = Base64.strict_encode64(File.read(image_data.tempfile))
        #     else
        #       render json: { errors: 'Image data is empty.' }, status: :bad_request and return
        #     end
    
        #   response = HTTParty.post(
        #     "https://api.zyler.com/v1/users/#{user_id}/selfies",
        #     basic_auth: auth,
        #     headers: {
        #       'accept' => 'application/json',
        #       'content-type' => 'application/json'
        #     },
        #     body: {
        #       image: image_data
        #     }.to_json
        #   )
    
        #   if response.code == 200
        #     parsed_response = response.parsed_response
        #     render json: parsed_response
        #   else
        #     render json: { errors: 'Failed to upload selfie.', message: response.body }, status: response.code
        #   end
        # end
    
        # def index #show image
        #   auth = {:username => "uu0c454d5fc501b167c2625fdd", :password => "c9e89f2d717e9763a3b035482c311d8b"}
        #   user_id = "uu0c454d5fc501b167c2625fdd"  
        #   selfie_id = "sscf08818081d91e6d0c365a75" 
        #   response = HTTParty.get(
        #     "https://api.zyler.com/v1/users/#{user_id}/selfies/#{selfie_id}",
        #     basic_auth: auth,
        #     headers: {
        #       'accept' => 'application/json'
        #     }
        #   )
    
        #   if response.code == 200
        #     parsed_response = response.parsed_response
        #     render json: parsed_response  # Send the parsed response as JSON
        #   else
        #     render json: { errors: 'Failed to retrieve selfie.', details: response.body }, status: :bad_request
        #   end
        # end
    
        private
    
        def create_zyler_user(parsed_response)
          result = parsed_response["result"]
        begin
            ZylerUser.create!(
              account_id: current_user.id,
              full_name: current_user.full_name,
              email: result["email"],
              user_name: result["id"],              
              password: result.dig("token", "code"),  
              user_id: result["userId"],  
              partner_terms_confirmed: result["partnerTermsConfirmed"] || true,  
              privacy_policy_confirmed: result["privacyPolicyConfirmed"] || true
            )
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error("ZylerUser creation failed: #{e.message}")
            raise
          end
        end
    
        # def set_measurements
        #    mannequin_params = params.require(:ai_virtual_mannequin).permit(
        #     :population_category, 
        #     :dress_size, 
        #     :clothing_locale, 
        #     :height, 
        #     :bra_back, 
        #     :bra_cup
        #   )
        #  @measurements = mannequin_params.to_h
        # end
    
        # def parse_json_strings(data)
        #   case data
        #   when String
        #     begin
        #       parsed = JSON.parse(data)
        #       # Recursively parse inner strings that could be JSON
        #       parse_json_strings(parsed)
        #     rescue JSON::ParserError
        #       data # Return the original string if it's not valid JSON
        #     end
        #   when Hash
        #     data.transform_values { |value| parse_json_strings(value) }
        #   when Array
        #      data.map { |item| parse_json_strings(item) }
        #     else
        #      data
        #   end
        # end
end
