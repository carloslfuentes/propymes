class CreateConfigurationMailers < ActiveRecord::Migration
  def self.up
    create_table :configuration_mailers do |t|
      t.string  :name
      t.integer :object_id
      t.string  :object_type
      t.string  :delivery_method
      t.string  :address
      t.string  :port
      t.string  :domain
      t.string  :user_name
      t.string  :password
      t.string  :authentication
      t.string  :enable_starttls_auto
      t.boolean  :is_active, :default=>true
      t.timestamps
    end
  end

  def self.down
    drop_table :configuration_mailers
  end
end
