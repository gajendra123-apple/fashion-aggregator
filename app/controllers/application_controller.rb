class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    SECRET = ENV['SECRET_KEY'] ||  Rails.application.secrets.secret_key_base
    def encode_data(payload)
        token = JWT.encode payload, SECRET, "HS256"
        return token
    end
    
    def decode_data(token)
        begin
            data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
            return data
        rescue => e
            puts e
        end
    end
  
    skip_before_action :verify_authenticity_token
    # protect_from_forgery with: :exception
    # include Authentication
    # before_action :set_current_user

    # include Authentication
    # skip_before_action :current_user, only: [:login]


    # before_action :set_current_user

    # private
    
    # def set_current_user
    #     @current_user = current_user
    #     unless @current_user
    #         render json: { error: 'Unauthorized user' }, status: :unauthorized
    #     end
    # end
end