class ConsultsController < InheritedResources::Base
  has_scope :for_patient
  
  def index
    @consults = Consult.for_patient params[:patient_id]
  end
  
  def new
    @consult = Consult.new(:user_id=>current_user.id,:patient_id=>params[:patient_id],:cite_id=>params[:cite_id])
  end
  
  def create
    @consult = Consult.new params[:consult]
    unless @consult.save
      flash[:warning] = @consult.errors.full_messages
      redirect_to :back
      return
    end
    redirect_to patient_consult_path(@consult.patient_id, @consult.id)
  end
  
  def print_prenscription
    @consult = Consult.find_by_id params[:id]
    respond_to do |format|
      format.html { render :action => 'result', :layout=>false}
      format.xml { render "print_prenscription" }
      format.pdf { render_jasper_report :collection => @consult, :select_criteria=>"/print_prenscription/prenscription/medicine", :format=>"pdf" }
    end
  end
  
  def create_documents
    payment_method = params[:payment_method]
    insurance = params[:insurance]
    consult_id = params[:id]
    if consult_id.present?
      @consult = Consult.find_by_id consult_id
      if @consult.create_document(insurance,{:payment_method=>payment_method})
        flash[:warning] = "Se creo Con exito"
      else
        flash[:warning] = "No se Pudo Crear "
      end
    else
      flash[:warning] = "No se encontro consulta"
    end
    redirect_to :back
  end
    
end
