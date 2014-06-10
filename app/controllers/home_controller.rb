class HomeController < ApplicationController
  
  def index
    if current_user.is_manager?
      manager
      render :action => 'manager'
    else
      operator
      render :action => 'operator'
    end
  end
  
  def operator
    if (@station = PConfig::Station.find_by_ip_station(request.ip.to_s)).present?
      @working_day = WorkingDay.get_working_day(@station,current_user.id, params[:product_id])
      @rate_graph = @working_day.rate_graph
      @working_days = @station.working_days.pending_change.created_today(Date.today)
    else
      flash[:error] = t("messages.ip_not_found")
    end
  end
  
  def manager
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
    working_day =  WorkingDay.find_by_id params[:working_day_id]
    hash = {}
    hash[:selectedAction] = params[:selectedAction]
    hash[:timer] = params[:timer]
    case params[:selectedAction].to_s
    when "start"
      hash[:status] = working_day.start_working_day
    when "standby"
      hash[:status] = working_day.standby_working_day
    when "stop"
      hash[:status] = working_day.stop_working_day
    else
      hash[:status] = false
    end
    render :json => hash.to_json
  end
  
  def add_items
    working_day =  WorkingDay.find_by_id params[:working_day_id]
    hash = {}
    hash_send={:number_piece=>params[:number_piece],:time=>params[:time]}
    hash[:status] = working_day.calculate_item_piece(hash_send)
    hash[:working_days] = working_day.station.working_days.pending_change.created_today(Date.today).map{|working| [{:product => working.product.name, :max => working.standard.item_number, :value => working.number_piece}]}
    hash[:number_piece] = working_day.number_piece
    hash[:rate_graph] = working_day.rate_graph.to_json
    hash[:effective_time] = working_day.station.get_sum_effective_time
    render :json => hash.to_json
  end
  
  def change_product
    hash = {}
    working_day =  WorkingDay.find_by_id params[:working_day_id]
    working_day.selected_product({:product_id=>params[:product_id]})
    hash[:flash] = "Mensaje"
    render :json => hash.to_json
  end
  
end
