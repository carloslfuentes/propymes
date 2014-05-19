class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :description
      t.boolean :is_enabled
      t.timestamps
    end
  end
end
