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
    
    def index
      @stations_lineal = PConfig::Station.only_lineal
      @stations_base = PConfig::Station.only_base      
    end
    
    def choose_products
      @station = PConfig::Station.find_by_id params[:id]
      @station_products = @station.product_stations.map{|r| r.product_id.to_s+"|"+r.product.name}.join(",")
    end
  end
end
