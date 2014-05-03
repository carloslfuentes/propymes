class DocumentsController < InheritedResources::Base
  
  def build_pdf
    document = Document.find_by_id params[:id]
    buffer_file = document.build_pdf
    Attach.add_attach(buffer_file,document.id,{:type_file=>"pdf",:document_type=>"Document"})
    redirect_to :back
  end
  
  def invoices
    @document = Document.find_by_id params[:id]
    respond_to do |format|
      format.html { render :action => 'result', :layout=>false}
      format.xml { render "invoices" }
      format.pdf { render_jasper_report :collection => @document, :select_criteria=>"/invoices/doc", :format=>"pdf" }
    end
  end
  
end
