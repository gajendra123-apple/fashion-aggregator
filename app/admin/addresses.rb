ActiveAdmin.register Address do
  permit_params :address_type, :recipient_name, :street_address, :city, :state, :zip_code, :country, :phone_number

  index do
    selectable_column
    id_column
    column :address_type
    column :recipient_name
    column :street_address
    column :city
    column :state
    column :zip_code
    column :country
    column :phone_number

    actions
  end

  filter :address_type
  filter :recipient_name
  filter :street_address
  filter :city
  filter :state
  filter :zip_code
  filter :country
  filter :phone_number

  form do |f|
    f.inputs do
      f.input :address_type
      f.input :recipient_name
      f.input :street_address
      f.input :city
      f.input :state
      f.input :zip_code
      # f.input :country
      f.input :phone_number
    end
    f.actions
  end

  show do
    attributes_table do
      row :address_type
      row :recipient_name
      row :street_address
      row :city
      row :state
      row :zip_code
      row :country
      row :phone_number
      row :created_at
      row :updated_at
    end
  end
end