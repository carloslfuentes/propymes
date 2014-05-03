class Document < ActiveRecord::Base
  
  belongs_to :consult
  belongs_to :insurance
  belongs_to :patient
  belongs_to :state
  belongs_to :country
  belongs_to :medic, :class_name => "User", :foreign_key => "medic_id"
  has_one    :attach, :class_name => 'Attach', :foreign_key => "object_id"
  belongs_to :payment_method, :foreign_key => "payment_method_id"
  
  validates_presence_of :payment_method_id
  validates_presence_of :rfc
  validates_presence_of :consult_id
  include JasperRails
  def build_pdf
    opts={}
    opts[:parm_criteria] = "/invoices/doc"
    opts[:template_param] = "../../lib/formats/invoices/invoices.xml.builder"
    opts[:jasper_file_param] = "../../lib/formats/invoices/invoices.jasper"
    opts[:document_locals] = self
    result = buffer_jasper_report :collection => self, :select_criteria=>opts[:parm_criteria], :format=>"pdf", :filename=> "invoice_" + self.id.to_s + ".pdf", :template => opts[:template_param], :jasper_file => opts[:jasper_file_param], :document => opts[:document_locals]
    end
  
end
