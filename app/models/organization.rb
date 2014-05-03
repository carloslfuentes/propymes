class Organization < ActiveRecord::Base
  has_many   :medicaments
  has_many   :addresses, :foreign_key => "organization_id"
  has_many   :services
  has_many   :payment_methods
  has_many   :insurance
  has_many   :users
  has_one    :time_limit
  has_one    :product, :foreign_key => "product_id"
  accepts_nested_attributes_for :medicaments, :addresses, :users
  
  before_save :generate_number_polize
  
  def generate_number_polize
    external = Digest::MD5.hexdigest(self.name + Date.today.to_s) 
    self.external_code = external
    organization_to_duplicate = {:name=>self.name,
                                 :description=>self.description,
                                 :rfc=>self.rfc,
                                 :external_code=>self.external_code}
    Client.create(organization_to_duplicate)
    
  end
  
end
