ActiveAdmin.register Status do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :status_name
  #
  # or
  #
  # permit_params do
  #   permitted = [:status_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :status_name

  index do
    selectable_column
    id_column
    column :status_name
    column "Products Count" do |status|
      status.products.count
    end
    actions
  end

  form do |f|
    f.inputs "Status Details" do
      f.input :status_name
    end
    f.actions
  end
end
