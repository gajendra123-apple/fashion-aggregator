ActiveAdmin.register Product do
  permit_params :name, :description, :category_type, :price, :image_url, :stock_quantity


  index do
    selectable_column
    id_column
    column :name
    column :description
    # column "Category Type" do |product|
    #  # product.category_type.titleize if product.category_type.present?
    # end
    # column "Image" do |product|
    #   if product.image.attached?
    #     image_tag url_for(product.image), height: '100'
    #   else
    #     "No Image"
    #   end
    # end
    column :price
    column :image_url
    column :stock_quantity
    column :created_at

    actions
  end

  filter :name
  filter :description
  filter :price
  filter :stock_quantity
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      #f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
      f.input :category, as: :select, collection: Category.category_types.keys.map { |type| [type.titleize, type] }

      f.input :image_url, as: :file
      f.input :stock_quantity
    end
    f.actions
  end
end
