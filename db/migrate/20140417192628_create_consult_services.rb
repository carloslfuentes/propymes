class CreateConsultServices < ActiveRecord::Migration
  def self.up
    create_table :consult_services do |t|
      t.integer :consult_id
      t.integer :service_id
      t.decimal :sub_total, :precision => 15, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :consult_services
  end
end
