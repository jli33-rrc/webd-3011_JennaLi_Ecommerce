ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :first_name, :last_name, :email, :address, :city, :postal_code, :province_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :email, :address, :city, :postal_code, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :first_name, :last_name, :email, :address, :city, :postal_code, :province_id

  filter :first_name
  filter :last_name
  filter :email
  filter :province
  filter :city
  filter :postal_code

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :province
    column :city
    column :postal_code
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :address
      row :city
      row :postal_code
      row :province
      row :created_at
      row :updated_at
    end

    panel "Purchases" do
      table_for customer.purchases do
        column :id
        column :subtotal
        column :gst
        column :pst
        column :hst
        column :total
        column :created_at
        column("View") { |p| link_to "View", admin_purchase_path(p) }
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Customer Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :province_id,
              label: "Province",
              as: :select,
              collection: Province.order(:name).map { |p| [p.name, p.id] }
    end
    f.actions
  end
end
