class PatientsController < InheritedResources::Base
  
  def new
    @patient = Patient.new
    @addresses = Address.new
  end
  
  def edit
    @patient = Patient.find_by_id params[:id]
    @addresses = @patient.addresses
    @addresses = Address.new if @addresses.blank?
  end
  
  def get_patient_for_medic
    @patient = Patient.for_user_medic params[:user_id]
    hash={}
    hash[:cite_patient_id] = @patient.map{|p| [p.name,p.id]} if @patient.present?
    render :json => hash.to_json
  end
  
end
