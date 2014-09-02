class HomeController < ApplicationController
  
  def index
    if current_user.is_manager?
      manager
    else
      operator
    end
  end
  
  def operator
    if (@station = PConfig::Station.find_by_ip_station(request.ip.to_s)).present?
      @working_day = WorkingDay.get_working_day(@station,current_user.id, params[:product_id])
      @rate_graph = @station.rate_graph
      @working_days = @station.working_days.pending_change
      @avarange_time_second = @working_day.get_averenge_time_second
      render :action => 'operator'
    else
      flash[:error] = t("messages.ip_not_found")
      #Aun lo voy a modificar !! SF
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/101", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
  end
  
  def manager
    #Falta crear scope para linea y batch
    @type_line = WorkingDay.actives
    @type_batch = WorkingDay.actives
    render :action => 'manager'
  end
  
  def validate_status
    hash = {}
    @working_id = WorkingDay.find(params[:working_day_id])
    if @working_id.status == "waiting_active" && @working_id.product_id.blank?
      hash[:status] = true
      hash[:flash] = "Esta Iniciado"
    else
      hash[:status] = false
      hash[:flash] = "Pendiente"
    end
    render :json => hash.to_json
  end
  
  def calculate_items
    working_day =  WorkingDay.find_by_ip params[:working_day_id]
    working_day.calculate_item({:ip=>request.ip,:number_piece=>params[:number_piece]})
  end
  
  def timer_actions
    @station = PConfig::Station.find_by_ip_station(request.ip.to_s)
    working_day = WorkingDay.get_working_day(@station,current_user.id, params[:product_id])
    
    hash = {}
    hash[:selectedAction] = params[:selectedAction]
    hash[:timer] = params[:time]
    case params[:selectedAction].to_s
    when "change_product"
      working_day = working_day.selected_product({:product_id=>params[:product_id]})
      hash[:select_product] = working_day.product.name
      hash[:working_day_id] = working_day.id
      hash[:effectiveTime_hours] = working_day.effective_time.hour
      hash[:effectiveTime_minutes] = working_day.effective_time.min
      hash[:effectiveTime_seconds] = working_day.effective_time.sec
      
    when "start"
      hash[:status] = working_day.start_working_day({:timer=>params[:timer].nullo.if_nil("00:00:00")})
    
    when "add_item"
      hash_send={:number_piece=>params[:number_piece],:time=>params[:time]}
      hash[:status] = working_day.calculate_item_piece(hash_send)
      hash[:working_days] = working_day.station.working_days.pending_change.map{|working| [{:product => working.product.name, :max => working.target_pieces, :value => working.nullo.number_piece.if_nil(0)}]}
      hash[:number_piece] = working_day.number_piece
      hash[:rate_graph] = working_day.station.rate_graph.to_json
    
    when "standby"
      hash[:status] = working_day.standby_working_day(:stoppage_id => params[:stoppage_id])
      hash[:stoppage_time] = working_day.stoppage.time.strftime("%H:%M:%S")
    
    when "stop"
      working_day.station.working_days.pending_change.each do |row|
        row.stop_working_day
      end
      hash[:status] = true  #  stop_working_day
    else
      hash[:status] = false
    end
    #Timers
    hash[:boot_variable] = PConfig::BootVariable.get_time_sum(working_day.standard.nullo.boot_variables.only_start_variable.if_nil([])).strftime("%H:%M:%S")
    hash[:effective_time] = working_day.effective_time.strftime("%H:%M:%S") if working_day.effective_time.present?
    hash[:disponible_time] = OperationTimes::Deduct.basic(working_day.disponible_time.strftime("%H:%M:%S"),hash[:effective_time]) if working_day.disponible_time.present?
    hash[:delayed_time] = working_day.delayed_time.strftime("%H:%M:%S") if working_day.delayed_time.present?
    
    render :json => hash.to_json
  end
  
  def graphs_to_manager
    hash = {}
    @working_days = WorkingDay.actives
    hash[:graphs] = []
    @working_days.each do |working_day|
      hash[:graphs] << working_day.station.rate_graph
    end
    render :json => hash.to_json
  end
  
  def select_graph
    
  end
  
end
