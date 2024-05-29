ActiveAdmin.register Promotion do
  permit_params :promotion_name, :description, :discount_percentage, :start_date, :end_date

  index do
    selectable_column
    id_column
    column :promotion_name
    column :description
    column :discount_percentage
    column :start_date
    column :end_date
    column :created_at
    column :updated_at

    actions
  end
  
  filter :promotion_name
  filter :description
  filter :discount_percentage
  filter :start_date
  filter :end_date
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :promotion_name
      f.input :description
      f.input :discount_percentage
      f.input :start_date
      f.input :end_date
    end
    f.actions
  end

  show do 
    attributes_table do
      row :promotion_name
      row :description
      row :discount_percentage
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end
  end
end
