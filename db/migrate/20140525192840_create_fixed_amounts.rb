class CreateFixedAmounts < ActiveRecord::Migration
  def change
    create_table :fixed_amounts do |t|
      t.string  :name
      t.float   :amount
      t.boolean :is_enabled, :default=>true
      t.string  :description
      t.timestamps
    end
  end
end
