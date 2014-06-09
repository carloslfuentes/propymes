class CreateStandardTypes < ActiveRecord::Migration
  def change
    create_table :standard_types do |t|
      t.string :name
      t.timestamps
    end
  end
end
