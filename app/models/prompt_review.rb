class PromptReview < ApplicationRecord
  self.table_name = :prompt_reviews
  belongs_to :prompt_manager, class_name: 'PromptManager'
  enum review: { like: 'like', unlike: 'unlike' }

  validates :comment, length: { maximum: 100 }
  validates :scoring, inclusion: { in: 1..10 }

  def self.ransackable_attributes(auth_object = nil)
    ["comment", "created_at", "id", "id_value", "prompt_manager_id", "review", "scoring", "updated_at"]
  end
end
