xml.instruct! :xml, :version=>"1.0", :encoding=>"utf-8"
xml.invoices do
  xml.doc do
    xml.id  document.id
    xml.patient document.patient.name
    xml.medic document.medic.name
    xml.total  document.amount_total
    xml.sub_total  document.amount_sub_total
    xml.tax1  document.amount_tax1
   end
end