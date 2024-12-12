require 'openai'

  class PromptService
    def self.response_chat(messages, version)
      client = OpenAI::Client.new(access_token: ENV['CHATGPT_ACCESS_TOKEN'])
      
      begin
        response = client.chat(
          parameters: {
            model: version,
            messages: messages,
            temperature: 0.7
          }
        )
        message_content = response.dig("choices", 0, "message", "content")
        if message_content
          message_content
        else
          Rails.logger.error("Unexpected GPT response format: #{response.inspect}")
          nil
        end
      rescue OpenAI::Error, StandardError => e
        Rails.logger.error("Error fetching GPT response: #{e.class} - #{e.message}")
        nil
      end
    end
  end
