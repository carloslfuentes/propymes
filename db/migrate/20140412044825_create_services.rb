class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string    :name
      t.integer   :organization_id
      t.integer   :user_id
      t.string    :description, :limit=>512
      t.boolean   :is_active, :default=>true
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
