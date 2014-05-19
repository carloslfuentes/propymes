class CreateStoppageByCategories < ActiveRecord::Migration
  def change
    create_table :stoppage_by_categories do |t|
      t.string :name
      t.string :description
      t.boolean :is_enabled
      t.timestamps
    end
  end
end
