ActiveAdmin.register Coupon do
  permit_params :active, :expiration_date, :minimum_purchase_amount,
   :redemption_instructions, :discount_percentage, :coupon_name
  index do
    selectable_column
    id_column
    column :coupon_name
    column :code
    column :active
    column :expiration_date
    column :usage_limit
    column :minimum_purchase_amount
    column :usage_count
    column :redemption_instructions
    column :discount_percentage
    column :created_at
    column :updated_at

    actions
  end

  filter :coupon_name
  filter :code
  filter :active
  filter :expiration_date
  filter :minimum_purchase_amount
  filter :usage_count
  filter :redemption_instructions
  filter :discount_percentage
  filter :created_at

  form do |f|
    f.inputs do
      f.input :coupon_name 
      f.input :discount_percentage 
      f.input :active
      f.input :expiration_date
      f.input :minimum_purchase_amount
      f.input :redemption_instructions
    end
    f.actions
  end

  show do 
    attributes_table do
      row :coupon_name
      row :code
      row :active
      row :expiration_date
      row :minimum_purchase_amount
      row :usage_count
      row :usage_limit
      row :redemption_instructions
      row :discount_percentage
      row :created_at
      row :updated_at
    end
  end
end

