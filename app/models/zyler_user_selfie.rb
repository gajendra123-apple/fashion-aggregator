class ZylerUserSelfie < ApplicationRecord
    self.table_name = :zyler_user_selfies
    
    belongs_to :zyler_user, class_name: "ZylerUser"
end
     

  