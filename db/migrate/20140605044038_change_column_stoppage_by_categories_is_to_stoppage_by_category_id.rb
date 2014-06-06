class ChangeColumnStoppageByCategoriesIsToStoppageByCategoryId < ActiveRecord::Migration
  def up
    rename_column :events, :stoppage_by_categories_id, :stoppage_by_category_id
  end

  def down
    rename_column :events, :stoppage_by_category_id, :stoppage_by_categories_id
  end
end
