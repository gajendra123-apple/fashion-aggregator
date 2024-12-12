class ZylerUser < ApplicationRecord
    self.table_name = :zyler_users
    has_one :zyler_user_selfie, class_name: "ZylerUserSelfie", dependent: :destroy
    belongs_to :account, class_name: "Account"
    
end
