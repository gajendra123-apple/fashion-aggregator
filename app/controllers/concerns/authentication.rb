# module Authentication
#     extend ActiveSupport::Concern
  
#     included do
#       before_action :current_user
#     end
  
#     def current_user
#       token = request.headers['Authorization']&.split(' ')&.last
#       return unless token
#       data = decode_data(token)
#       user_id = data[0]['user_data']
#       User.find_by(id: user_id) if user_id.present?
#     end
  
#     def encode_data(payload)
#       token = JWT.encode payload, SECRET_KEY, "HS256"
#       return token
#     end
  
#     def decode_data(token)
#       begin
#         data = JWT.decode token, SECRET_KEY, true, { algorithm: "HS256" }
#         return data
#       rescue => e
#         puts e
#       end
#     end
  
#     private
  
#     def SECRET_KEY
#       ENV['SECRET_KEY']
#     end
# end
  