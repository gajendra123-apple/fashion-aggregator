ActiveAdmin.register Product do
  permit_params :name, :description, :category_id, :subcategory_id, 
  :price, :image,  :stock_quantity, :color, :size, :brand_name

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :category do |product|
      product&.category&.name
    end
    column :image do |product|
      if product.image.attached?
        image_tag(product.image, width: 100 , height: 100)
      else
        "No image attached"
      end
    end
    column :price
    column :brand_name 
    column :color
    column :size
    column :stock_quantity
    column :created_at

    actions
  end

  filter :name
  filter :description
  filter :price
  filter :color
  filter :size
  filter :stock_quantity
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :category_id, as: :select, collection: Category.all.map { |f| [f.name.humanize, f.id] }
      f.input :subcategory_id, as: :select, collection: Subcategory.all.map { |f| [f.name.humanize, f.id] }
      f.input :image, as: :file
      f.input :color
      f.input :size, as: :select
      f.input :brand_name, as: :select, collection: Brand.all.map { |f| [f.name.humanize] }
      f.input :stock_quantity
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category do |product|
        product.category.name if product.category
      end
      row :image do |product|
        if product.image.attached?
         image_tag(product.image, width: 100 , height: 100)
        else
         "No image attached"
        end
      end
      row :color
      row :size
      row :price
      row :brand_name
      row :stock_quantity
      row :created_at
      row :updated_at
    end
  end
end