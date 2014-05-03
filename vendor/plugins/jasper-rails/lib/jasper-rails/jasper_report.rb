class JasperReport
  include Config
  
  class << self
    
    def generate(opts = {}) #jasper_file, format, select_criteria)
      opts[:jasper_file] << '.jasper' if !opts[:jasper_file].match(/\.jasper$/)
      interface_classpath=File.dirname(__FILE__)+"/../../includes/xml_jasper_interface/"      
      separator=':'
      if File.dirname(__FILE__)[1]==":"[0]
        separator=';'
      end  
      #interface_classpath << separator+"#{app_root}/lib/*"
      interface_classpath << separator+"#{File.dirname(__FILE__)}/../../includes/jasperreports/lib/*"
      
      result=nil
#      ActionController::Base.logger.error "java -Djava.awt.headless=true -cp \"#{interface_classpath}\" XmlJasperInterface -o#{opts[:format] || 'pdf'} -f\"#{RAILS_ROOT}/app/views/#{opts[:jasper_file]}\" -x#{opts[:select_criteria]} -d\"#{RAILS_ROOT}/public/images/reports\""
#      ActionController::Base.logger.error opts[:xml]

      IO.popen "java -Djava.awt.headless=true -cp \"#{interface_classpath}\" XmlJasperInterface -o#{opts[:format] || 'pdf'} -f\"#{RAILS_ROOT}/app/views/#{opts[:jasper_file]}\" -x#{opts[:select_criteria]} -d\"#{RAILS_ROOT}/public/images/reports\"", "w+b" do |pipe|
        pipe.write opts[:xml]
        pipe.close_write
        result = pipe.read
        pipe.close
      end
      return result
    end
    
  end
end
