ActiveAdmin.register PurchaseProduct do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :purchase_id, :product_id, :price, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:purchase_id, :product_id, :price, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :purchase_id, :product_id, :price, :quantity

  index do
    selectable_column
    id_column
    column :purchase
    column :product
    column :price
    column :quantity
    column("Line Total") { |pp| pp.price * pp.quantity }
    actions
  end

  show do
    attributes_table do
      row :id
      row :purchase
      row :product
      row :price
      row :quantity
      row("Line Total") { |pp| pp.price * pp.quantity }
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Purchase Product" do
      f.input :purchase
      f.input :product
      f.input :price
      f.input :quantity
    end
    f.actions
  end
end
