class CreateMedicaments < ActiveRecord::Migration
  def self.up
    create_table :medicaments do |t|
      t.string :name
      t.string :description
      t.integer :organization_id
      t.string :external_code
      t.timestamps
    end
  end

  def self.down
    drop_table :medicaments
  end
end
