class RemoveProductIdToStation < ActiveRecord::Migration
  def up
    remove_column :stations, :product_id
  end

  def down
    add_column :stations, :product_id, :integer
  end
end
