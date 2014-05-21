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
        @working_day = WorkingDay.get_working_day(@sation.id,current_user.id)
    else
      flash[:error] = "No se encontro estacion con ip " + request.ip
    end
  end
  
  def manager
    
  end
  
end
