class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :product_id
      t.integer :quantity
      t.integer :status
      t.integer :ean
      t.boolean :favorite

      t.timestamps
    end
  end
end
