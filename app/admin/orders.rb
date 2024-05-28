ActiveAdmin.register Order do
  permit_params :order_date, :total_amount, :shipping_address, :billing_address, :status, :user_id

  index do
    selectable_column
    id_column
    column :order_date
    column :total_amount
    column :shipping_address
    column :billing_address
    column :status 
    column :user_id
    column :created_at
    column :updated_at
    actions
  end

  filter :order_date
  filter :total_amount
  filter :shipping_address
  filter :billing_address
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :order_date
      f.input :total_amount
      f.input :shipping_address
      f.input :billing_address
      f.input :status ,as: :select, include_blank: "please select status"
      f.input :user_id
    end
    f.actions
  end

  show do 
    attributes_table do
      row :order_date
      row :total_amount
      row :shipping_address
      row :billing_address
      row :status
      row :created_at
      row :updated_at
    end
  end
end
