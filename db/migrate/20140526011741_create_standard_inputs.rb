class CreateStandardInputs < ActiveRecord::Migration
  def change
    create_table :standard_inputs do |t|
      t.integer :standard_id
      t.integer :input_id
      t.timestamps
    end
  end
end
