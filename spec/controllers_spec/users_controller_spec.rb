require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  describe 'POST #sign_up' do
    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          name: Faker::Name.name,
          email: "example@gmail.com",
          password: "Janaklodhi@123"
        }
      end

      it 'creates a new user' do
        post :sign_up, params: { user: valid_attributes }
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'when the request is invalid' do
      let(:invalid_attributes) do
        {
          name: '',
          email: 'invalid_email',
          password: 'short'
        }
      end

      it 'returns failure response' do
        post :sign_up, params: { user: invalid_attributes }
        response_data = JSON.parse(response.body)
        expect(response_data["error"]).to eq("Name can't be blank, Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character")
      end
    end

    context 'when an exception is raised' do
      let(:valid_attributes) do
        {
          name: Faker::Name.name,
          email: "example@gmail.com",
          password: "Janaklodhi@123"
        }
      end

      before do
        # Simulate an ArgumentError by defining a method that raises an exception
        allow(User).to receive(:new).and_raise(ArgumentError, 'Invalid argument')
      end

      it 'returns failure response with exception message' do
        post :sign_up, params: { user: valid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('Invalid argument')
      end
    end
  end
  
  describe 'POST #login' do
    context 'when the user exists and provides correct credentials' do
      it 'logs in the user and returns authentication token' do
        user = FactoryBot.create(:user, password: "Password@23")
        post :login, params: { user: { email: user.email, password: "Password@23" } }
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'when the user does not exist' do
      it 'returns a not found response' do
        post :login, params: { user: { email: nil, password: 'password123' } }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('User with email not found')
      end
    end

    context 'when the user provides incorrect password' do
      it 'returns an unprocessable entity response' do
        user = FactoryBot.create(:user, password: "Password@123")
        post :login, params: { user: { email: user.email, password: 'wrongpassword' } }
        data = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(data['message']).to eq('Wrong password')
      end
    end

    context 'when an exception is raised' do
      it 'returns an unprocessable entity response with the exception message' do
        allow(User).to receive(:find_by).and_raise(StandardError, 'Unexpected error')
        post :login, params: { user: { email: 'example@gmail.com', password: 'password123' } }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('An error occurred: Unexpected error')
      end
    end

    describe 'POST #forgot_password' do
      before do
        Rails.application.routes.default_url_options[:host] = 'localhost:3000'
      end
      context 'when user exists' do
        it 'sends password reset instructions and returns success message' do
          user = FactoryBot.create(:user, password: "Password@23")
          post :forgot_password, params: { user: { email: user.email } }
          response_data = JSON.parse(response.body)
          expect(response_data['message']).to eq('Password reset instructions sent successfully ')
        end
      end

      context 'when the user does not exist' do
        it 'returns a not found response' do
          user = FactoryBot.create(:user, password: "Password@23")
          post :forgot_password, params: { user: { email: nil } }
          response_data = JSON.parse(response.body)
          expect(response_data["error"]).to eq("User not found with email")
        end
      end
    end
    
    describe 'PATCH #reset_password' do
      let(:user) { FactoryBot.create(:user) }
      context 'when token is valid and password update is successful' do
        it 'updates the password and returns a success message' do
          patch :reset_password, params: { token: user.reset_password_token, user: { password: "NewPassword@123", password_confirmation: "NewPassword@123" } }
          expect(response).to have_http_status(:success)
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['message']).to eq("Password successfully updated")
          user.reload
          expect(user.reset_password_token).to be_nil
        end
      end
    end

    context 'when token is valid but passwords do not match' do
      it 'returns a password mismatch error' do
        patch :reset_password, params: { token: user.reset_password_token, user: { password: "NewPassword@123", password_confirmation: "DifferentPassword@123" } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq("Password and confirmation do not match")
      end
    end

    context 'when token is valid but passwords are missing' do
      it 'returns a missing passwords error' do
        patch :reset_password, params: { token: user.reset_password_token, user: { password: "", password_confirmation: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq("New password and confirmation are required")
      end
    end

    context 'when token is invalid or expired' do
      it 'returns an invalid or expired token error' do
        user.update(reset_password_sent_at: 2.days.ago) # Make the token expired
        patch :reset_password, params: { token: user.reset_password_token, user: { password: "NewPassword@123", password_confirmation: "NewPassword@123" } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq("Invalid or expired token")
      end
    end
  end
end