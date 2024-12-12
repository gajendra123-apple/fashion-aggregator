    class PromptManagersController < ApplicationController
      # include BuilderJsonWebToken::JsonWebTokenValidation
      before_action :validate_json_web_token
      before_action :authenticate_user
      before_action :set_prompt_manager, only: [:show, :create_review]
  
      def create
        @prompt_manager = PromptManager.new(prompt_params)
  
        if @prompt_manager.save
          messages = [
            { role: 'system', content: @prompt_manager.prompt_template },
            { role: 'user', content: @prompt_manager.question }
          ]
  
          gpt_version = @prompt_manager.gpt_version.gsub('_', '-')
          response_content = PromptService.response_chat(messages, gpt_version)
          if response_content.present?
            @prompt_manager.update(answer: response_content)
            render json:  PromptManagerSerializer.new(@prompt_manager).serializable_hash, status: :ok
          else
            @prompt_manager.destroy
            render json: { error: 'Failed to fetch response from GPT' }, status: :unprocessable_entity
          end
        else
  
          render json: { errors: @prompt_manager.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
      def create_review
        if @prompt_manager.prompt_review.present?
          # If a review already exists, update it
          if @prompt_manager.prompt_review.update(review_params)
            render json: { message: 'Review updated successfully' }, status: :ok
          else
            render json: { errors: @prompt_manager.prompt_review.errors.full_messages }, status: :unprocessable_entity
          end
        else
          @prompt_review = @prompt_manager.build_prompt_review(review_params)
          if @prompt_review.save
            render json: { message: 'Review created successfully' }, status: :ok
          else
            render json: { errors: @prompt_review.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
  
      def index
        @prompt_managers = PromptManager.all
        if @prompt_managers.present?
         render json: PromptManagerSerializer.new(@prompt_managers).serializable_hash, status: :ok
        else
          render json: { error: 'No prompt found' }, status: :not_found
        end
      end
  
      def show
        render json: PromptManagerSerializer.new(@prompt_manager).serializable_hash, status: :ok
      end
  
      private
  
      def authenticate_user
        @account = Account.find_by(id: @token&.id)
        if @account.nil?
          render json: { error: "Account not found" }, status: :unauthorized
        elsif @account.role.name != 'end-user'
          render json: { error: 'Unauthorized', message: "You are Not Authorized user" }, status: :forbidden
        end
      end
  
      def prompt_params
        params.require(:prompt_manager).permit(:gpt_version, :prefix, :question, :prompt_template)
      end
  
      def set_prompt_manager
        @prompt_manager = PromptManager.find_by(id: params[:id])
        render json: { error: 'Prompt not found' }, status: :not_found if @prompt_manager.nil?
      end
  
      def review_params
        params.require(:prompt_review).permit(:scoring, :review, :comment)
      end
    end
  end