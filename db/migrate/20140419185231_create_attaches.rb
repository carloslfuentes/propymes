class CreateAttaches < ActiveRecord::Migration
  def self.up
    create_table :attaches do |t|
      t.string    :name_file
      t.integer   :version
      t.string    :path
      t.integer   :object_id
      t.string    :document_type
      t.string    :directory
      t.string    :type_file
      t.timestamps
    end
  end

  def self.down
    drop_table :attaches
  end
end

