class AiVirtualMannequinSerializer < ActiveModel::Serializer
    attributes :id, :full_name, :user_name, :password, :user_id, :privacy_policy_confirmed
end
  