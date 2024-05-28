ActiveAdmin.register Favorite do
  permit_params :is_favorite, :product_id, :user_id

  index do
    selectable_column
    id_column
    column :is_favorite
    column :product_id
    column :user_id
    column :order_id
    column :created_at
    column :updated_at

    actions
  end
  
  filter :is_favorite
  filter :product_id
  filter :user_id
  filter :created_at
  
  # form do |f|
  #   f.inputs do
  #     f.input :is_favorite, default: false
  #     f.input :product, as: :select, include_blank: "please select product"
  #     f.input :user, as: :select, include_blank: "please select user"
  #   end
  #   f.actions
  # end

  show do 
    attributes_table do
      row :is_favorite
      row :product
      row :user
      row :created_at
      row :updated_at
    end
  end
end
