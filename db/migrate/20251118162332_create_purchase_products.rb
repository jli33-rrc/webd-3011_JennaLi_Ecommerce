class CreatePurchaseProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
