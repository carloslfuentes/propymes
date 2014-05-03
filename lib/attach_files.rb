module AttachFiles
  module Docuemts
    def self.attach(buffer_file,opts)
      source_path = "C:/sigmed/document"
      FileUtils::mkdir_p source_path + "/#{opts[:name]}"
      source_path += "/invoice_#{opts[:name]}.pdf"
      f = File.open( source_path ,'wb')
      f.write(buffer_file)
      f.close
    end
  end
end