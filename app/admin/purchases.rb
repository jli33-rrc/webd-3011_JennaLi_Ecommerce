ActiveAdmin.register Purchase do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :customer_id, :subtotal, :gst, :pst, :hst, :total
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :subtotal, :gst, :pst, :hst, :total]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :customer_id, :subtotal, :gst, :pst, :hst, :total,
                purchase_products_attributes: [:id, :product_id, :price, :quantity, :_destroy]

  filter :customer
  filter :subtotal
  filter :gst
  filter :pst
  filter :hst
  filter :total
  filter :created_at
  
  index do
    selectable_column
    id_column
    column :customer
    column :subtotal
    column :gst
    column :pst
    column :hst
    column :total
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :subtotal
      row :gst
      row :pst
      row :hst
      row :total
      row :created_at
      row :updated_at
    end

    panel "Products in Purchase" do
      table_for purchase.purchase_products do
        column :product
        column :price
        column :quantity
        column("Line Total") { |pp| pp.price * pp.quantity }
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs "Purchase Info" do
      f.input :customer_id,
              label: "Customer",
              as: :select,
              collection: Customer.all.map { |c| ["#{c.first_name} #{c.last_name}", c.id] }
      f.input :subtotal
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :total
    end

    f.object.purchase_products.build if f.object.purchase_products.empty?

    f.inputs "Purchase Products" do
      f.has_many :purchase_products, allow_destroy: true, new_record: true do |pp|
        pp.input :product
        pp.input :price
        pp.input :quantity
      end
    end

    f.actions
  end
end
