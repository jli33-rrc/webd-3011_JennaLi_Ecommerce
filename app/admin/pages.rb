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

  remove_filter :image_attachment
  remove_filter :image_blob
  
  permit_params :title, :slug, :content, :image

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :updated_at
    column "Image" do |page|
      if page.image.attached?
        image_tag page.image.variant(resize_to_limit: [50, 50]), alt: page.image_alt.presence || page.title
      else
        "No image"
      end
    end
    column "Alt Text", :image_alt
    actions
  end

  form do |f|
    f.inputs "Page Details" do
      f.input :title
      f.input :slug, hint: "Use simple lowercase words like 'about' or 'contact'"
      f.input :content, as: :text
      f.input :image, as: :file, hint: (
        f.object.image.attached? ?
          image_tag(f.object.image.variant(resize_to_limit: [100, 100]), alt: f.object.image_alt.presence || f.object.title) :
          content_tag(:span, "No image uploaded")
      )
      f.input :image_alt, label: "Image Alt Text", hint: "Describe the image for accessibility (used as alt text)"
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
      row :image do |page|
        if page.image.attached?
          image_tag page.image.variant(resize_to_limit: [300, 300]), alt: page.image_alt.presence || page.title
        else
          "No image uploaded"
        end
      end
      row :image_alt
    end
  end
end
