class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.date     :date
      t.string   :format,                    :limit => 64
      t.string   :medic_id
      t.string   :patient_id
      t.string   :payment_method
      t.string   :rfc,                    :limit => 64
      t.string   :street
      t.string   :number,                    :limit => 32
      t.string   :address1
      t.string   :address2
      t.string   :address3
      t.string   :address4
      t.string   :address5
      t.string   :address6
      t.string   :city,                      :limit => 128
      t.integer  :state_id
      t.integer  :country_id
      t.string   :zip_code,                  :limit => 64
      t.text     :comments
      t.string   :organization_rfc
      t.string   :organization_street
      t.string   :organization_number
      t.string   :organization_address1
      t.string   :organization_address2
      t.string   :organization_address3
      t.string   :organization_address4
      t.string   :organization_address5
      t.string   :organization_address6
      t.string   :organization_zip_code
      t.string   :organization_city
      t.integer  :organization_state_id
      t.integer  :organization_country_id
      t.decimal  :amount_sub_total,                         :precision => 15, :scale => 3
      t.decimal  :amount_tax1,                              :precision => 15, :scale => 3
      t.decimal  :amount_tax2,                              :precision => 15, :scale => 3
      t.decimal  :amount_tax3,                              :precision => 15, :scale => 3
      t.decimal  :amount_total,                             :precision => 15, :scale => 3
      t.decimal  :amount_due,                               :precision => 15, :scale => 3
      t.decimal  :amount_paid,                              :precision => 15, :scale => 3
      t.integer  :service_id
      t.integer  :consult_id
      t.string   :certified_number
      t.text     :stamp
      t.text     :original_chain
      t.string   :document_type,             :limit => 32
      t.string   :uuid,                      :limit => 256
      t.string   :certified_number_sat,      :limit => 256
      t.string   :stamp_sat,                 :limit => 512
      t.string   :folio_series,              :limit => 10
      t.integer  :folio
      t.date     :canceled_date
      t.boolean  :cancelled, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
