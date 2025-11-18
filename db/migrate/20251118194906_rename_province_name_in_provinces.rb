class RenameProvinceNameInProvinces < ActiveRecord::Migration[8.0]
  def change
    rename_column :provinces, :name, :province_name
  end
end
