class Product < ActiveRecord::Base
  has_one :organization, :foreign_key => "product_id"
  scope :enabled, where(:is_active=>true)
  def self.select_product_costs
    self.enabled.sort_by(&:name).map{|p| [("#{p.name} - $#{p.cost}"), p.id]}
  end
end
