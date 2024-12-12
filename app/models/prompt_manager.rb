  class PromptManager < ApplicationRecord
    self.table_name = :prompt_managers

    validates :question, :gpt_version, presence: true
    enum gpt_version: { gpt_4o_mini: 'gpt-4o-mini', gpt_4: 'gpt-4', gpt_4o: 'gpt-4o' }
    has_one :prompt_review, class_name: 'PromptReview', dependent: :destroy
    after_initialize :set_default_prompt_template, if: :new_record?
    accepts_nested_attributes_for :prompt_review

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "country_start", "country_end", "updated_at", "gpt_version", "prefix", "threshold", "question", "contact_results", "country_cont","country_eq", "language", "answer", "context", "prompt_template"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["prompt_review"]
    end

    private

    def set_default_prompt_template
      self.prompt_template ||= "Please provide a comprehensive response based on the context given. Ensure clarity, thoroughness, and include any relevant examples or details to support your answer."
    end
  end