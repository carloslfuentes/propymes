class CreateRateServices < ActiveRecord::Migration
  def self.up
    create_table :rate_services do |t|
      t.string      :name
      t.integer     :service_id
      t.integer     :organization_id
      t.integer     :user_id
      t.decimal     :cost, :precision => 15, :scale => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :rate_services
  end
end
