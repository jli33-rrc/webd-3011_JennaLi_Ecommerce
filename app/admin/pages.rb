ActiveAdmin.register Page do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :slug, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :slug, :content]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :title, :slug, :content

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Page Details" do
      f.input :title
      f.input :slug, hint: "Use simple lowercase words like 'about' or 'contact'"
      f.input :content, as: :text
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :slug
      row :content do |page|
        raw page.content
      end
    end
  end
end
