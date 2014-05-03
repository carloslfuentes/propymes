class AddSendNotificationToCite < ActiveRecord::Migration
  def self.up
    add_column :cites, :send_notification, :integer
  end

  def self.down
    remove_column :cites, :send_notification
  end
end
