class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :document_id
      t.decimal :payment, :precision => 15, :scale => 3
      t.integer :payment_method_id
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
