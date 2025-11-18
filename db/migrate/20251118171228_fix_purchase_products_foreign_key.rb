class FixPurchaseProductsForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :purchase_products, column: :order_id rescue nil

    rename_column :purchase_products, :order_id, :purchase_id

    add_foreign_key :purchase_products, :purchases, column: :purchase_id
  end
end
