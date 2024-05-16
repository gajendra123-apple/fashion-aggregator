module Authentication
    extend ActiveSupport::Concern
  
    included do
      before_action :current_user
    end
    
    def current_user
      begin
        token = request.headers[:token]&.split(' ')&.last
        return unless token
        data = decode_data(token)
        user_id = data[0]['user_data']
        @current_user = User.find_by(id: user_id) if user_id.present?
      rescue StandardError => e  
        Rails.logger.error("An error occurred in current_user method: #{e.message}") 
        @current_user = nil      
      end
    end

    def encode_data(payload)
      token = JWT.encode payload, secret_key, "HS256"
      return token
    end
  
    def decode_data(token)
      begin
        data = JWT.decode token, secret_key, true, { algorithm: "HS256" }
        return data
      rescue => e
        puts e
      end
    end
  
    private

    def secret_key
      ENV['SECRET_KEY']
    end
end