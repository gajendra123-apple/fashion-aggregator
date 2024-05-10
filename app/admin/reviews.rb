ActiveAdmin.register Review do
  permit_params :rating, :review_text, :date, :product_id, :user_id

  index do
    selectable_column
    id_column
    column :rating
    column :review_text
    column :date
    column :product_id
    column :user_id
    column :created_at

    actions
  end
  
  filter :rating
  filter :review_text
  filter :date
  filter :product_id
  filter :user_id
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :rating
      f.input :review_text
      f.input :date
      f.input :product, as: :select, include_blank: "please  select product "
      f.input :user, as: :select, include_blank: "please  select user"
    end
    f.actions
  end

  show do 
    attributes_table do
      row :rating
      row :review_text
      row :date
      row :product_id
      row :user_id
      row :created_at
      row :updated_at
    end
  end
end
