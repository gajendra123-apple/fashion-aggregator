ActiveAdmin.register Wishlist do
  permit_params :date_added

  index do
    selectable_column
    id_column
    column :date_added
    column :created_at

    actions
  end
  
  filter :date_added
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :date_added
    end
    f.actions
  end

  show do 
    attributes_table do
      row :date_added
      row :created_at
      row :updated_at
    end
  end
end
