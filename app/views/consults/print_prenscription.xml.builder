xml.instruct! :xml, :version=>"1.0", :encoding=>"utf-8"
xml.print_prenscription do
  xml.doctor  
  xml.paciente  @consult.patient.name
  xml.prenscription do
    @consult.prescription.medicines.each do |medicine|
      xml.medicine do
        xml.doctor  
        xml.paciente  medicine.prescription.patient.name
        xml.medicine  medicine.medicine
        xml.dose  medicine.dose
        xml.description  medicine.description
       end
    end
  end 
end