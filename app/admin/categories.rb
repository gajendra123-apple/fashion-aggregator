ActiveAdmin.register Category do
  permit_params :category_type

  index do
    selectable_column
    id_column
    column :category_type
    column :created_at

    actions
  end

  filter :category_type
  filter :created_at

  form do |f|
    f.inputs do
      f.input :category_type
    end
    f.actions
  end

  show do 
    attributes_table do
      row :category_type
      row :created_at
      row :created_at
      row :updated_at
    end
  end
end
