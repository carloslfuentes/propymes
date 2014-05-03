class AttachesController < ApplicationController
  
  def view_files
    attach = Attach.find_by_id params[:id]
    dataFile = File.open(attach.path,"rb"){ |f| f.read }
    send_data  dataFile, :type => attach.get_mime_type, :disposition => "inline", :filename => attach.name_file
    
  end

end
