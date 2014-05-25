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
    if (@sation = PConfig::Station.find_by_ip_station(request.ip.to_s)).present?
      @working_day = WorkingDay.get_working_day(@sation.id,current_user.id, params[:product_id])
    else
      flash[:error] = t("messages.ip_not_found")
    end
  end
  
  def manager
  end
  
  def validate_status
    if current_user.working_day.first.status == "waiting_active"
      hash = {}
      hash = "Hola"
      render :json => hash.to_json
    end
  end
  
end
