ActiveAdmin.register Payment do
  permit_params :payment_date, :amount, :payment_method

  index do
    selectable_column
    id_column
    column :payment_date
    column :amount
    column :payment_method
    column :created_at
    column :updated_at

    actions
  end
  
  filter :payment_date
  filter :amount
  filter :payment_method
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :payment_date
      f.input :amount
      f.input :payment_method
    end
    f.actions
  end

  show do 
    attributes_table do
      row :payment_date
      row :amount
      row :payment_method
      row :created_at
      row :updated_at
    end
  end
end
