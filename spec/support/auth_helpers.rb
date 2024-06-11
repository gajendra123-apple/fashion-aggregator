# # spec/support/auth_helpers.rb
# module AuthHelpers
#   include Authentication

#   def auth_headers(user)
#     byebug
#     token = encode_data(user_data: user.id)
#     { 'Authorization': "Bearer #{token}" }
#   end
# end

# RSpec.configure do |config|
#   config.include AuthHelpers, type: :controller
# end
