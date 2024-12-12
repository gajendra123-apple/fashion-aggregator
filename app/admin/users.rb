ActiveAdmin.register User do
  permit_params :name, :email, :password

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :password
    column :created_at
    column :updated_at

    actions
  end
  
  filter :name
  filter :email
  filter :password
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do 
    attributes_table do
      row :name
      row :email
      row :password
      row :created_at
      row :updated_at
    end
  end
end