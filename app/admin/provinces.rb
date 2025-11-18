ActiveAdmin.register Province do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :gst, :pst, :hst
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :gst, :pst, :hst]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :province_name, :gst, :pst, :hst

  index do
    selectable_column
    id_column
    column :province_name
    column :gst
    column :pst
    column :hst
    actions
  end

  show do
    attributes_table do
      row :id
      row :province_name
      row :gst
      row :pst
      row :hst
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs "Province Tax Rates" do
      f.input :province_name
      f.input :gst
      f.input :pst
      f.input :hst
    end
    f.actions
  end
end
