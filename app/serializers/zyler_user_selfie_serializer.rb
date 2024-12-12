class ZylerUserSelfiesSerializer < ActiveModel::Serializer
    attributes :id, :selfie_id, :head_placement_x, :head_placement_y, :head_scale, :color_correction, :warnings, :created_at
   
end
