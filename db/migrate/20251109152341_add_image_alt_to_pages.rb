class AddImageAltToPages < ActiveRecord::Migration[8.0]
  def change
    add_column :pages, :image_alt, :string
  end
end
