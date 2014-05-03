class Attach < ActiveRecord::Base
  
  belongs_to :document, :class_name => "Document", :foreign_key => "object_id"
  
  def self.add_attach(buffer_file,object_id,opts={})
    
    opts[:object_id] = object_id
    attach = Attach.find_by_object_id_and_document_type(object_id,opts[:document_type])
    if attach.present?
      attach.version += 1
    end
    #FIXME crear un catalogo del directorio
    opts[:directory]="C:/sigmed/#{opts[:document_type]}/#{object_id}"
    opts[:name_file] = "invoice_#{attach.nullo.version.if_nil(1)}.#{opts[:type_file]}"
    opts[:path] = "#{opts[:directory]}/#{opts[:name_file]}"
    if attach.present?
      attach.update_attributes(opts)
    else
      opts[:version] = 1
      attach = Attach.new(opts)
      attach.save
      FileUtils::mkdir_p opts[:directory]
    end
    f = File.open( opts[:path] ,'wb')
    f.write(buffer_file)
    f.close
  end
  
  def get_mime_type
    case self.type_file
    when "pdf"
      return "application/pdf"
    else
      puts "You gave me #{a} -- I have no idea what to do with that."
    end
  end
  
end
