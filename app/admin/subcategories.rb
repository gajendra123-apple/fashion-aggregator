ActiveAdmin.register Subcategory do
    permit_params :name, :category_id
  
  index do
    selectable_column
    id_column
    column :name
    column "Category Id" do |product|
      product.category_id
    end
    column :created_at
    column :updated_at

    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :category_id, as: :select, include_blank: "please select category",collection: Category.all.map { |f| [f.category_type.humanize, f.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end
end
  