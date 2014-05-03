class Consult < ActiveRecord::Base
  #attr_accessible :user_id, :patient_id, :description
  belongs_to    :patient
  belongs_to    :user
  has_one       :prescription
  has_one       :cite
  has_one       :medical_record
  has_many      :consult_services
  has_many      :services, :through => :consult_services
  has_many      :documents
  accepts_nested_attributes_for :prescription, :medical_record, :consult_services
  
  validates_presence_of :description
  after_save :close_cite
  validate :validate_consult
  
  scope :for_patient, proc {|patient_id| where(:patient_id=>patient_id)}
  def close_cite
    cite = Cite.find_by_id self.cite_id
    cite.update_attribute(:is_active,false)
  end
  
  def create_document(insurance_id,opt={})
    patient = self.patient
    address_patient = patient.addresses.first
    opt[:date]=Date.today
    opt[:medic_id]=self.user_id
    opt[:patient_id]=self.patient_id
    opt[:amount_sub_total]=self.sub_total
    opt[:amount_tax1]=self.tax
    opt[:amount_total]=self.total
    opt[:amount_due]=self.total
    opt[:amount_paid]=0
    opt[:consult_id]=self.id
    #direccion del paciente
    opt[:rfc]="xxx00000xx"#self.rfc
    opt[:street]=address_patient.street
    opt[:number]=address_patient.number
    opt[:city]=address_patient.city
    opt[:state_id]=1#address_patient.state
    opt[:country_id]=1#address_patient
    opt[:zip_code]=address_patient.zip_code
    #direccion del doctor
    opt[:organization_rfc]="xxx00000xx"#self.rfc
    opt[:organization_street]=address_patient.street
    opt[:organization_number]=address_patient.number
    opt[:organization_city]=address_patient.city
    opt[:organization_state_id]=1#address_patient.state
    opt[:organization_country_id]=1#address_patient
    opt[:organization_zip_code]=address_patient.zip_code
    if opt[:payment_method].to_i == 1
      opt[:document_type]="Insurance"
      opt[:insurance_id]=insurance_id
    end
    opt[:document_type]="Invoice" if opt[:payment_method].to_i != 1 
    
    doc = Document.new(opt)
    return doc.save
  end
  
  def validate_consult
    
    if self.consult_services.blank?
      errors.add :sub_total, "No tiene servicios"
    end
    
    #if self.prescription.medicines.blank?
    #  errors.add :sub_total, "No hay medicamentos"
    #end
    
    self.sub_total = 0.0
    self.consult_services.each do |consult_service|
      self.sub_total += consult_service.service.cost
    end
    if self.sub_total <= 0
      errors.add :sub_total, "No puede ser cero"
    end
    #FIXME se tiene que hacer un catalogo para el iva
    self.tax = (self.sub_total * 0.16)
    self.total = self.sub_total + self.tax
    return true
  end
  
end
