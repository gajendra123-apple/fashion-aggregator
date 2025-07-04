  class PromptManagerSerializer < ActiveModel::Serializer
    attributes :prompt_id, :gpt_version, :prefix, :question, :prompt_template, :created_at, :answer
   
    attribute :prompt_id do |object|
      object.id
    end

    attribute :prompt_review do |object|
      if object.prompt_review
        prompt_review_json = object.prompt_review.as_json(except: [:updated_at])
        prompt_review_json['prompt_review_id'] = prompt_review_json.delete('id')
        prompt_review_json
      else
        nil
      end
    end
  end
  