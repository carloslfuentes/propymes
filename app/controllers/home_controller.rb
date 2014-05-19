class HomeController < ApplicationController
  
  def index
    if current_user.is_manager?
      redirect_to manager_path
    else
      redirect_to operator_path
    end
  end
  
  def operator
    if (@sation = PConfig::Station.find_by_ip_station(request.ip.to_s)).present?
      if (@working_day = WorkingDay.where("status in ('pausa','waiting_active','active') and station_id = ? and operator_id = ?", @sation.id, current_user.id).first).blank?
        @working_day = WorkingDay.create(:reason=>'por iniciar',:status=>'waiting_active',:station_id=>@sation.id,:operator_id=>current_user.id)
      end
    else
      flash[:error] = "No se encontro estacion con ip " + request.ip
    end
  end
  
  def manager
    
  end
  
end
