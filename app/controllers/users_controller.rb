class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def sign_up
      begin
        @user = User.new(user_params)
        if @user.save
          success_response(@user)
        else
          faliour_respone(@user.errors.full_messages.join(', '))
        end
      rescue ArgumentError => e
        faliour_respone(e.message)
      end
    end
  
    def login
      begin
        user = User.find_by(email: params[:user][:email])
        if user.nil?
          render json: { message: "User with email not found" }, status: :not_found
        elsif user.password == params[:user]['password']
          token = encode_data({ user_data: user.id })
          render json: { user: user, token: token }
        else
          render json: { message: "Wrong password" }, status: :unprocessable_entity
        end
      rescue => e
        render json: { message: "An error occurred: #{e.message}" }, status: :unprocessable_entity
      end
    end

    def forgot_password
      email_param = params[:user][:email]
      @user = User.find_by(email: email_param)
      if @user.present?
        @user.generate_password_token!
        UserMailer.password_reset_email(@user).deliver_now
        render json: { message: "Password reset instructions sent successfully " }
      else
        render json: { error: "User not found with email" }, status: :not_found
      end
    end

    def reset_password
      token = params[:token]
      user = User.find_by(reset_password_token: token)
      if user && !expired?(token)
        if params[:user][:password].present? && params[:user][:password_confirmation].present?
          if params[:user][:password] == params[:user][:password_confirmation]
            if user.update(password: params[:password])
              user.update(reset_password_token: nil)
              render json: { message: "Password successfully updated" }
            else
              render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
          else
            render json: { error: "Password and confirmation do not match" }, status: :unprocessable_entity
          end
        else
          render json: { error: "New password and confirmation are required" }, status: :unprocessable_entity
        end
      else
        render json: { error: "Invalid or expired token" }, status: :unprocessable_entity
      end
    end


    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def expired?(token)
      user = User.find_by(reset_password_token: token)
      return false unless user
      user.reset_password_sent_at < 24.hours.ago
    end
  
  
    def success_response(user)
      render json: {user: user}
    end
  
    def faliour_respone(message, status = :unprocessable_entity)
      render json: { error: message }, status: status
    end
  end  