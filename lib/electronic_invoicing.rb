#require "soap/wsdlDriver"

module ElectronicInvoicing
  module XmlCreation
    def self.get_hash_cfdi(doc)
      
      payment_modes = {"Partials" => "Pago en parcialidades",
          "One Exhibition" => "Pago en una sola exhibicion"}
      
      fiscal_units = {"days" => "Dias",
          "not_applicable" => "No Aplica"}
      
      tipo_comprobante = {"Invoice" => "ingreso",
        "Credit Note" => "egreso",
        "Partial Invoice" => "ingreso",
        "Partial Credit Note" => "egreso"}
      
      metodo_pago = (doc.payment_method.blank?)?("Unidentified"):(doc.payment_method)
      
      methods = {"Cash" => "Efectivo",
      "Credit Card" => "Tarjeta de credito",
      "Debit Card" => "Tarjeta de debito",
      "Credit" => "Credito",
      "Transfer" => "Transferencia",
      "Check" => "Cheque",
      "Unidentified" => "No identificado"}
      
      metodo_pago = (methods[metodo_pago].blank?) ? ("No identificado"):(methods[metodo_pago])
      
      if metodo_pago == "Efectivo" or metodo_pago == "Credito" or metodo_pago == "No identificado"
        cuenta_doc = ""
      else
        cuenta_doc = (doc.account_last_digits.blank?)?(""):(doc.account_last_digits)
      end
          
      doc_total = doc.amount_total
      doc_iva = doc.amount_tax1
      doc_descuento = 0
      doc_subtotal = doc_total - doc_iva + doc_descuento
      
      xml_version = "3.2"
      xml_xmlns_cfdi = "http://www.sat.gob.mx/cfd/3"
      xml_xmlns_xsi = "http://www.w3.org/2001/XMLSchema-instance"
      xml_xsi_schemaLocation = "http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"
      
      emisor_rfc = doc.nullo.organization_rfc.if_nil("")
      emisor_nombre = doc.nullo.medic.name.if_nil("")
      
      if (ad1 = doc.nullo.medic.addresses.detect{|ea| ea.is_fiscal == 1})
        emisor_address = ad1.first
      else
        emisor_address = doc.nullo.medic.addresses.first
      end
      emisor_calle = emisor_address.nullo.street.if_nil("")
      emisor_numero = emisor_address.nullo.number.if_nil("")
      emisor_col = emisor_address.nullo.colonia.if_nil("")
      emisor_ciudad = emisor_address.nullo.city.if_nil("")
      emisor_estado = emisor_address.state.name.if_nil("")
      emisor_pais = emisor_address.country.name.if_nil("")
      emisor_cp = emisor_address.nullo.zip_code.if_nil("")
      fiscal_location = emisor_address.fiscal_location
      
      regimen = emisor_address.regimen
      
      receptor_rfc = doc.nullo.rfc.if_nil("")
      receptor_nombre = doc.nullo.patient.name.if_nil("")
      receptor_calle = doc.nullo.street.if_nil("")
      receptor_numero = doc.nullo.number.if_nil("")
      receptor_interior =doc.nullo.address1.if_nil("")
      receptor_col = doc.nullo.address2.if_nil("")
      receptor_estado = doc.nullo.state.name.if_nil('')
      receptor_pais = doc.nullo.country.name.if_nil('Mexico')
      receptor_cp = doc.nullo.zip_code.if_nil('')
      receptor_ciudad = doc.nullo.city.if_nil('')
      
      doc_type = doc.document_type
      services = nil
      
      if doc_type == "Invoice"
        services = doc.consult.services
      elsif doc_type == "Insurance"
        services = nil
      end
      if services.blank?
        return nil
      end
      
      tasa_iva = 999
      if tasa_iva == "999.00"
        tasa_iva = sprintf("%.2f",((doc_iva/doc_subtotal) * 100))
      end
      
      cfdi = {}
      date_time = Time.now.to_s.split(" ")
      cfdi[:cfdi_Comprobante] = {
        :version => xml_version,
        :serie => doc.folio_series,
        :folio => doc.folio.to_s,
        :fecha => date_time[0]+"T"+date_time[1],
        :sello => "",
        :noAprobacion => "",
        :anoAprobacion => "",
        :formaDePago => payment_modes[doc.payment_method.name],
        :noCertificado => "",
        :Certificado => "",
        :condicionesPago => "",
        :subTotal => sprintf("%.2f",doc_subtotal),
        :descuento => sprintf("%.2f",doc_descuento),
        :motivoDescuento => "",
        :TipoCambio => "",
        :Moneda => "",
        :total => sprintf("%.2f",doc_total),
        :tipoDeComprobante => tipo_comprobante[doc.document_type],
        :metodoDePago => metodo_pago,
        :LugarExpedicion => fiscal_location,
        :NumCtaPago => cuenta_doc,
        :FolioFiscalOrig => "",
        :SerieFolioFiscalOrig => "",
        :FechaFolioFiscalOrig => "",
        :MontoFolioFiscalOrig => "",
        :xmlns_cfdi => xml_xmlns_cfdi,
        :xmlns_xsi => xml_xmlns_xsi,
        :xsi_schemaLocation => xml_xsi_schemaLocation
      }
      
      cfdi[:cfdi_Emisor] = {
            :rfc => emisor_rfc,
            :nombre => emisor_nombre.gsub(/\s+/, " ").strip,
            :cfdi_DomicilioFiscal => {
              :calle => emisor_calle.gsub(/\s+/, " ").strip ,
              :noExterior => emisor_numero,
              :noInterior=> "",
              :colonia=> emisor_col.gsub(/\s+/, " ").strip,
              :localidad=> "",
              :referencia=> "",
              :municipio=> emisor_ciudad,
              :estado=> emisor_estado,
              :pais=> emisor_pais,
              :codigoPostal=> emisor_cp
            },
            :cfdi_ExpedidoEn => {
              :calle => "",
              :noExterior=> "",
              :noInterior=> "",
              :colonia=> "",
              :localidad=> "",
              :referencia=> "",
              :municipio=> "",
              :estado=> "",
              :pais=> "",
              :codigoPostal=> ""
            },
            :cfdi_RegimenFiscal => [
              #{:Regimen => "General de Ley"},
              {:Regimen => regimen}
            ]
        }
       
        cfdi[:cfdi_Receptor] = {
            :rfc => receptor_rfc.gsub(/\s+/, " ").strip,
            :nombre => receptor_nombre.gsub(/\s+/, " ").strip,
            :cfdi_Domicilio => {
              :calle => receptor_calle.gsub(/\s+/, " ").strip,
              :noExterior => receptor_numero.gsub(/\s+/, " ").strip,
              :noInterior => receptor_interior.gsub(/\s+/, " ").strip,
              :colonia => receptor_col.gsub(/\s+/, " ").strip,
              :localidad => "",
              :referencia => "",
              :municipio => receptor_ciudad.gsub(/\s+/, " ").strip,
              :estado => receptor_estado.gsub(/\s+/, " ").strip,
              :pais => receptor_pais.gsub(/\s+/, " ").strip,
              :codigoPostal => receptor_cp.gsub(/\s+/, " ").strip
            }
        }
       
        cfdi[:cfdi_Conceptos] = []
       
        sum_monto_concepto = 0
        service_sub_total = services.sum("cost")
        service_size = services.size
        
        services.each do |service|
          cantidad = 1
          monto_concepto = service.cost
          descripcion = service.name
          valor_unitario = (monto_concepto/cantidad)
          unidad = "Servicio"#fixme agregar unidad en el servicio
         
          cfdi[:cfdi_Conceptos] << {
            :cfdi_Concepto => {
              :cantidad => sprintf("%.2f",cantidad) ,
              :unidad => unidad ,
              :noIdentificacion => "" ,
              :descripcion => descripcion.gsub(/\s+/, " ").strip,
              :valorUnitario => sprintf("%.2f",valor_unitario) ,
              :importe =>  sprintf("%.2f",monto_concepto)
             }
          }
        end
         
        cfdi[:cfdi_Impuestos] = {
          :totalImpuestosRetenidos => "" ,
          :totalImpuestosTrasladados => doc_iva.to_s ,
          :cfdi_Retenciones => [
          {
            :cfdi_Retencion => {
              :impuesto => 0 ,
              :importe => 0
            }
          }
          ],
          :cfdi_Traslados => [{
            :cfdi_Traslado => {
              :impuesto => "IVA" ,
              :tasa => tasa_iva , # FIXME ver que aplica cuanddo hay varios conceptos con tasas diferentes
              :importe => doc_iva.to_s
            }
          }
          ]
        }
       
        return self.get_cfdi_xml(cfdi, doc)
       
    end
   
   
    def self.get_cfdi_xml(datos={}, document)
      if datos.empty?# si hash esta vacio
        return nil
      end
     
      cadenaoriginal =""
      existe_domiciliofiscalE=0
      existe_expedidoenfiscalE=0
      existe_domicilioR=0
     
      if !(datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:calle].blank?) &&
        !(datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:municipio].blank?) &&
        !(datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:estado].blank?) &&
        !(datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:pais].blank?) &&
        !(datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:codigoPostal].blank?) then
        existe_domiciliofiscalE=1
      end
     
      if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:pais].blank?
        existe_expedidoenfiscalE=1
      end
     
      if !datos[:cfdi_Receptor][:cfdi_Domicilio][:pais].blank?
        existe_domicilioR=1
      end
      cfdi_add="cfdi"
      #definicion atributos del xml
      attributes_comprobante = {}
      attributes_emisor = {}
      attributes_comprobante["xmlns:cfdi"] = datos[:cfdi_Comprobante][:xmlns_cfdi].to_s
      
      attributes_comprobante["xmlns:xsi"] = datos[:cfdi_Comprobante][:xmlns_xsi].to_s
      attributes_comprobante["xsi:schemaLocation"] = datos[:cfdi_Comprobante][:xsi_schemaLocation].to_s
                    
      cadenaoriginal="||"+datos[:cfdi_Comprobante][:version].to_s
      attributes_comprobante["version"]=datos[:cfdi_Comprobante][:version].to_s
      if !datos[:cfdi_Comprobante][:serie].blank? #opcional
        if cfdi_add.blank? #solo para cfd
          cadenaoriginal+="|"+datos[:cfdi_Comprobante][:serie].to_s
        end
       attributes_comprobante["serie"]=datos[:cfdi_Comprobante][:serie].to_s
      end
     
      if !datos[:cfdi_Comprobante][:folio].blank? #opcional Para cfdi
        attributes_comprobante["folio"]=datos[:cfdi_Comprobante][:folio].to_s
      end
     
      cadenaoriginal+="|"+datos[:cfdi_Comprobante][:fecha].to_s
      attributes_comprobante["fecha"]=datos[:cfdi_Comprobante][:fecha].to_s
     
      cadenaoriginal+="|"+datos[:cfdi_Comprobante][:tipoDeComprobante].to_s 
      attributes_comprobante["tipoDeComprobante"]=datos[:cfdi_Comprobante][:tipoDeComprobante].to_s  
      cadenaoriginal+="|"+datos[:cfdi_Comprobante][:formaDePago].to_s
      attributes_comprobante["formaDePago"]=datos[:cfdi_Comprobante][:formaDePago].to_s
      
      if !datos[:cfdi_Comprobante][:condicionesPago].blank? #opcional
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:condicionesPago].to_s
        attributes_comprobante["condicionesDePago"]=datos[:cfdi_Comprobante][:condicionesPago].to_s
      end
     
      cadenaoriginal+="|"+datos[:cfdi_Comprobante][:subTotal].to_s
      attributes_comprobante["subTotal"]=datos[:cfdi_Comprobante][:subTotal].to_s
     
      if !datos[:cfdi_Comprobante][:descuento].blank? #opcional
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:descuento].to_s
        attributes_comprobante["descuento"]=datos[:cfdi_Comprobante][:descuento].to_s
      end
     
      if !datos[:cfdi_Comprobante][:motivoDescuento].blank? #opcional
        attributes_comprobante["motivoDescuento"]=datos[:cfdi_Comprobante][:motivoDescuento].to_s
      end
      
      if !cfdi_add.blank?#orden cadena para cfdi
        if !datos[:cfdi_Comprobante][:TipoCambio].blank?
          cadenaoriginal+="|"+datos[:cfdi_Comprobante][:TipoCambio].to_s
          attributes_comprobante["TipoCambio"]=datos[:cfdi_Comprobante][:TipoCambio].to_s
        end
       
        if !datos[:cfdi_Comprobante][:Moneda].blank?
          cadenaoriginal+="|"+datos[:cfdi_Comprobante][:Moneda].to_s
          attributes_comprobante["Moneda"]=datos[:cfdi_Comprobante][:Moneda].to_s
        end
       
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:total].to_s
        attributes_comprobante["total"]=datos[:cfdi_Comprobante][:total].to_s
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:metodoDePago].to_s
        attributes_comprobante["metodoDePago"]=datos[:cfdi_Comprobante][:metodoDePago].to_s
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:LugarExpedicion].to_s
        attributes_comprobante["LugarExpedicion"]=datos[:cfdi_Comprobante][:LugarExpedicion].to_s
       
        if !datos[:cfdi_Comprobante][:NumCtaPago].blank?
          cadenaoriginal+="|"+datos[:cfdi_Comprobante][:NumCtaPago].to_s
          attributes_comprobante["NumCtaPago"]=datos[:cfdi_Comprobante][:NumCtaPago].to_s
        end
      end #cfdi
      
      if !datos[:cfdi_Comprobante][:FolioFiscalOrig].blank?
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:FolioFiscalOrig].to_s
        attributes_comprobante["FolioFiscalOrig"]=datos[:cfdi_Comprobante][:FolioFiscalOrig].to_s
      end
      if !datos[:cfdi_Comprobante][:SerieFolioFiscalOrig].blank?
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:SerieFolioFiscalOrig].to_s
        attributes_comprobante["SerieFolioFiscalOrig"]=datos[:cfdi_Comprobante][:SerieFolioFiscalOrig].to_s
      end
      if !datos[:cfdi_Comprobante][:FechaFolioFiscalOrig].blank?
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:FechaFolioFiscalOrig].to_s
        attributes_comprobante["FechaFolioFiscalOrig"]=datos[:cfdi_Comprobante][:FechaFolioFiscalOrig].to_s
      end
      if  !datos[:cfdi_Comprobante][:MontoFolioFiscalOrig].blank?
        cadenaoriginal+="|"+datos[:cfdi_Comprobante][:MontoFolioFiscalOrig].to_s
        attributes_comprobante["MontoFolioFiscalOrig"]=datos[:cfdi_Comprobante][:MontoFolioFiscalOrig].to_s
      end
      
      #Emisor
      cadenaoriginal+="|"+datos[:cfdi_Emisor][:rfc].to_s
      attributes_emisor['rfc'] = datos[:cfdi_Emisor][:rfc].to_s
     
      if !datos[:cfdi_Emisor][:nombre].blank?
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:nombre].to_s
        attributes_emisor['nombre']=datos[:cfdi_Emisor][:nombre].to_s
      end
      
       #domicilio fiscal emisor
      attributes_domiciliofiscal = {}
      if existe_domiciliofiscalE==1
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:calle].to_s
        attributes_domiciliofiscal['calle'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:calle].to_s
       
        if !datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noExterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noExterior].to_s
          attributes_domiciliofiscal['noExterior'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noExterior].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noInterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noInterior].to_s
          attributes_domiciliofiscal['noInterior'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:noInterior].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:colonia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:colonia].to_s
          attributes_domiciliofiscal['colonia'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:colonia].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:localidad].blank?  
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:localidad].to_s
          attributes_domiciliofiscal['localidad'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:localidad].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:referencia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:referencia].to_s
          attributes_domiciliofiscal['referencia'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:referencia].to_s
        end
       
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:municipio].to_s
        attributes_domiciliofiscal['municipio'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:municipio].to_s
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:estado].to_s
        attributes_domiciliofiscal['estado'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:estado].to_s
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:pais].to_s
        attributes_domiciliofiscal['pais'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:pais].to_s
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:codigoPostal].to_s
        attributes_domiciliofiscal['codigoPostal'] = datos[:cfdi_Emisor][:cfdi_DomicilioFiscal][:codigoPostal].to_s
      end #end domicilio fiscal emisor
      
       #Expedido En
       attibutesExpedidoEn = {}
      if existe_expedidoenfiscalE==1
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:calle].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:calle].to_s
          attibutesExpedidoEn['calle']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:calle].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noExterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noExterior].to_s
          attibutesExpedidoEn['noExterior']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noExterior].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noInterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noInterior].to_s
          attibutesExpedidoEn['noInterior']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:noInterior].to_s
        end
       
        if datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:colonia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:colonia].to_s
          attibutesExpedidoEn['colonia']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:colonia].to_s
        end
       
        if datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:localidad].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:localidad].to_s
          attibutesExpedidoEn['localidad']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:localidad].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:referencia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:referencia].to_s
          attibutesExpedidoEn['referencia']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:referencia].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:municipio].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:municipio].to_s
          attibutesExpedidoEn['municipio']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:municipio].to_s
        end
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:estado].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:estado].to_s
          attibutesExpedidoEn['estado']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:estado].to_s
        end
       
        cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:pais].to_s
        attibutesExpedidoEn['pais']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:pais].to_s
       
        if !datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:codigoPostal].blank?
          cadenaoriginal+="|"+datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:codigoPostal].to_s
          attibutesExpedidoEn['codigoPostal']=datos[:cfdi_Emisor][:cfdi_ExpedidoEn][:codigoPostal].to_s
        end
      end #end Expedido En
      
      #Regimen Fiscal
      attributeRegimenFiscal = {}
      datos[:cfdi_Emisor][:cfdi_RegimenFiscal].each { |valor|
        cadenaoriginal+="|"+valor[:Regimen].to_s
        attributeRegimenFiscal['Regimen'] =valor[:Regimen].to_s
      }
      #end regimen fiscal
      
      #Receptor
      attributesReceptor ={}
      cadenaoriginal+="|"+datos[:cfdi_Receptor][:rfc].to_s
      attributesReceptor['rfc'] = datos[:cfdi_Receptor][:rfc].to_s
     
      if !datos[:cfdi_Receptor][:nombre].blank?
        cadenaoriginal+="|"+datos[:cfdi_Receptor][:nombre].to_s
        attributesReceptor['nombre'] =datos[:cfdi_Receptor][:nombre].to_s
      end
      
      # Domicilio Receptor
      attributes_Receptor_Domicilio = {}
      if existe_domicilioR==1
        
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:calle].blank?  
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:calle].to_s
          attributes_Receptor_Domicilio['calle'] = datos[:cfdi_Receptor][:cfdi_Domicilio][:calle].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:noExterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:noExterior].to_s
          attributes_Receptor_Domicilio['noExterior'] = datos[:cfdi_Receptor][:cfdi_Domicilio][:noExterior].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:noInterior].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:noInterior].to_s
          attributes_Receptor_Domicilio['noInterior'] = datos[:cfdi_Receptor][:cfdi_Domicilio][:noInterior].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:colonia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:colonia].to_s
          attributes_Receptor_Domicilio['colonia'] =datos[:cfdi_Receptor][:cfdi_Domicilio][:colonia].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:localidad].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:localidad].to_s
          attributes_Receptor_Domicilio['localidad'] =datos[:cfdi_Receptor][:cfdi_Domicilio][:localidad].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:referencia].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:referencia].to_s
          attributes_Receptor_Domicilio['referencia'] =datos[:cfdi_Receptor][:cfdi_Domicilio][:referencia].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:municipio].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:municipio].to_s
          attributes_Receptor_Domicilio['municipio'] =datos[:cfdi_Receptor][:cfdi_Domicilio][:municipio].to_s
        end
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:estado].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:estado].to_s
          attributes_Receptor_Domicilio['estado'] =datos[:cfdi_Receptor][:cfdi_Domicilio][:estado].to_s
        end
       
        cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:pais].to_s
        attributes_Receptor_Domicilio['pais'] = datos[:cfdi_Receptor][:cfdi_Domicilio][:pais].to_s
       
        if !datos[:cfdi_Receptor][:cfdi_Domicilio][:codigoPostal].blank?
          cadenaoriginal+="|"+datos[:cfdi_Receptor][:cfdi_Domicilio][:codigoPostal].to_s
          attributes_Receptor_Domicilio['codigoPostal'] = datos[:cfdi_Receptor][:cfdi_Domicilio][:codigoPostal].to_s
        end
      end #end domicilio Receptor
      
      #acceso cfdi_Conceptos
      attributesConceptos = {}
      attributes = {}
      i = 0
      datos[:cfdi_Conceptos].each { |valor|
        attributes = {}  
        cadenaoriginal+="|"+valor[:cfdi_Concepto][:cantidad].to_s
        attributes['cantidad'] = valor[:cfdi_Concepto][:cantidad].to_s
        cadenaoriginal+="|"+valor[:cfdi_Concepto][:unidad].to_s
        attributes['unidad'] = valor[:cfdi_Concepto][:unidad].to_s
        if !valor[:cfdi_Concepto][:noIdentificacion].blank?
          cadenaoriginal+="|"+valor[:cfdi_Concepto][:noIdentificacion].to_s
          attributes['noIdentificacion'] = valor[:cfdi_Concepto][:noIdentificacion].to_s
        end
        cadenaoriginal+="|"+valor[:cfdi_Concepto][:descripcion].to_s
        attributes['descripcion'] = valor[:cfdi_Concepto][:descripcion].to_s
        cadenaoriginal+="|"+valor[:cfdi_Concepto][:valorUnitario].to_s
        attributes['valorUnitario'] = valor[:cfdi_Concepto][:valorUnitario].to_s
        cadenaoriginal+="|"+valor[:cfdi_Concepto][:importe].to_s
        attributes['importe'] = valor[:cfdi_Concepto][:importe].to_s
        attributesConceptos[i] = attributes
        i += 1
       }#end Conceptos
       
       #acceso cfdi_Impuestos
      #cfdi_Impuestos Retenciones
      attributesImpuestosRetenciones = {}
      attributesimpuestRetenciones = {}
      if !datos[:cfdi_Impuestos][:totalImpuestosRetenidos].blank?
        attributesImpuestosRetenciones['totalImpuestosRetenidos'] = datos[:cfdi_Impuestos][:totalImpuestosRetenidos].to_s
         i = 0
        datos[:cfdi_Impuestos][:cfdi_Retenciones].each do |valor|
          attributes = {}
          cadenaoriginal+="|"+valor[:cfdi_Retencion][:impuesto].to_s
          attributes['impuesto'] = valor[:cfdi_Retencion][:impuesto].to_s
          cadenaoriginal+="|"+valor[:cfdi_Retencion][:importe].to_s
          attributes['importe'] = valor[:cfdi_Retencion][:importe].to_s
          attributesimpuestRetenciones[i] = attributes
          i += 1
        end
        cadenaoriginal+="|"+datos[:cfdi_Impuestos][:totalImpuestosRetenidos].to_s
      end #end retenciones
      
       #acceso cfdi_Impuestos Translados
      if !datos[:cfdi_Impuestos][:totalImpuestosTrasladados].blank?
       
        attributesimpuestos = {}
        attributesimpuestosTraslados = {}
        i = 0
        datos[:cfdi_Impuestos][:cfdi_Traslados].each do |valor|
          attributes = {}
          cadenaoriginal+="|"+valor[:cfdi_Traslado][:impuesto].to_s
          attributes['impuesto'] = valor[:cfdi_Traslado][:impuesto].to_s
          cadenaoriginal+="|"+valor[:cfdi_Traslado][:tasa].to_s
          attributes['tasa'] = valor[:cfdi_Traslado][:tasa].to_s
          cadenaoriginal+="|"+valor[:cfdi_Traslado][:importe].to_s
          attributes['importe'] = valor[:cfdi_Traslado][:importe].to_s
          attributesimpuestosTraslados[i] = attributes
          i += 1
        end
          cadenaoriginal+="|"+datos[:cfdi_Impuestos][:totalImpuestosTrasladados].to_s
          attributesimpuestos['totalImpuestosTrasladados']=datos[:cfdi_Impuestos][:totalImpuestosTrasladados].to_s
      end
      cadenaoriginal+="||"
      
      #end Translados
      #params_services = CfdipacConfiguration.organization_owner(document.organization_owner_id).first
      
      #path_key = params_services.file_name2 
      #path_cert = params_services.file_name1
      document.original_chain = cadenaoriginal.gsub("'", "&apos;")
    
      sello = "sello temp"#get_sign_cfdi(cadenaoriginal, path_key)
      
      attributes_comprobante["sello"]=sello
      
      arr_cert = "cert temp"#get_cert_cfdi(path_cert)
      certificado = arr_cert[0]
      varnoCertificado = arr_cert[1]
      
      attributes_comprobante["noCertificado"]=varnoCertificado
      attributes_comprobante["certificado"]=certificado.gsub(/[\n|\r|\n\r]/i,"")
      document.certified_number = varnoCertificado
      document.stamp = sello
      document.save
      array_names = []
      doc = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        
        xml.Comprobante(attributes_comprobante) {
          array_names << "Comprobante"
          xml.doc.root.namespace = xml.doc.root.namespace_definitions.first
          
          xml.Emisor(attributes_emisor){
            array_names << "Emisor"
            xml.DomicilioFiscal(attributes_domiciliofiscal)
            array_names << "DomicilioFiscal"
            if existe_expedidoenfiscalE==1
              xml.ExpedidoEn(attibutesExpedidoEn)
              array_names << "ExpedidoEn"
            end
            xml.RegimenFiscal(attributeRegimenFiscal)
            array_names << "RegimenFiscal"
          }
          xml.Receptor(attributesReceptor){
            array_names << "Receptor"
            xml.Domicilio(attributes_Receptor_Domicilio)
            array_names << "Domicilio"
          }
          xml.Conceptos {
            array_names << "Conceptos"
            attributesConceptos.each do |key, value|
              xml.Concepto(attributesConceptos[key])
              array_names << "Concepto"
            end
          }
          if !attributesImpuestosRetenciones.blank?
            xml.Impuestos(attributesImpuestos) {
              array_names << "Impuestos"
              attributesimpuestRetenciones.each do |key, value|
                xml.Retenciones(attributesimpuestRetenciones[key])
                array_names << "Retenciones"
              end
            }
          end
          if !attributesimpuestos.blank?
            xml.Impuestos(attributesimpuestos){
              array_names << "Impuestos"
              xml.Traslados {
                array_names << "Traslados"
                attributesimpuestosTraslados.each do |key, value|
                  xml.Traslado(attributesimpuestosTraslados[key])
                  array_names << "Traslado"
                end
              }
            }
          end
        }
      end
      
      
      #return (doc.to_xml).to_s
      #regreso = OrderNokogiri::parche_attributes(doc.to_xml, array_names.uniq, cfdi_add)
      #filexml = File.new('153.xml', "w")
      #filexml.write(return_xml)
      #filexml.close
      return doc.to_xml
      #return cadenaoriginal
    end
    
    def self.get_sign_cfdi(cadena_original, path_key_pem)
      pkey = OpenSSL::PKey::RSA.new(File.read(path_key_pem))
      sig  = pkey.sign(OpenSSL::Digest::SHA1.new, cadena_original)
      varsello=[sig].pack("m").gsub(/\n/, "") #Base64 encode
      
      return varsello
    end
    
    def self.get_cert_cfdi(path_cer_pem)
      certificado = OpenSSL::X509::Certificate.new(File.read(path_cer_pem))
      contador=1
      varnoCertificado=""
      certificado.serial.to_s(16).split("").each do |i|
        if contador % 2 == 0
          varnoCertificado += i
        end
        contador += 1
      end
      certificado =certificado.to_s()
      certificado.slice! "-----BEGIN CERTIFICATE-----"
      certificado.slice! "-----END CERTIFICATE-----"
      
      return [certificado, varnoCertificado]
    end
  end
end
    
    

