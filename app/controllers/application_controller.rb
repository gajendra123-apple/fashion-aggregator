class ApplicationController < ActionController::Base
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