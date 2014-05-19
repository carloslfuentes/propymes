module PConfig
  class StationsController < InheritedResources::Base
    def comprovate_ip
      #system('ping -n 4 -k 172.16.246.235')
      pt = PConfig::Station.rev_ip params[:ip_station]
      hash={}
      hash[:ping] = pt.ping?
      render :json => hash.to_json
    end
    
    def change_status
      hash = {}
      @working_day = WorkingDay.find_by_id params[:id]
      @working_day.status = params[:status]
      @working_day.reason = params[:reason]
      hash[:status] = @working_day.save ? params[:status] : "Problemas al guardar log"
      render :json => hash.to_json
    end
  end
end
