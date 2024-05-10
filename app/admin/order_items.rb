ActiveAdmin.register OrderItem do
  permit_params :quantity, :price, :product_id, :shoppingcart_id, :order_id

  index do
    selectable_column
    id_column
    column :quantity
    column :price
    column :quantity
    column :order_id
    column :product_id
    column :shoppingcart_id
    column :created_at

    actions
  end
  
  filter :quantity
  filter :price
  filter :created_at
  
  form do |f|
    f.inputs do
      f.input :quantity
      f.input :price
      # f.input :product, as: :select, include_blank: "please select product"
      # f.input :shoppingcart, as: :select, include_blank: "please select shoppingcart"
      # f.input :order, as: :select, include_blank: "please select order"
    end
    f.actions
  end

  show do 
    attributes_table do
      row :quantity
      row :price
      row :category_id
      row :shoppingcart_id
      row :order_id
      row :created_at
      row :updated_at
    end
  end
end
