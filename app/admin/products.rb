ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_name, :price, :description, :category_id, :status_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :price, :description, :category_id, :status_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :product_name, :price, :description, :category_id, :status_id, :image

  index do
    selectable_column
    id_column
    column :product_name
    column :price
    column :category
    column :status
    column "Image" do |product|
      if product.image.attached?
        image_tag product.image.variant(resize_to_limit: [50, 50])
      else
        "No image"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :product_name
      f.input :price
      f.input :description
      f.input :category
      f.input :status
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(f.object.image.variant(resize_to_limit: [100, 100])) : content_tag(:span, "No image uploaded")
    end
    f.actions
  end

  show do
    attributes_table do
      row :product_name
      row :price
      row :description
      row :category
      row :status
      row :image do |product|
        if product.image.attached?
          image_tag product.image.variant(resize_to_limit: [300, 300])
        else
          "No image uploaded"
        end
      end
    end
  end
end
