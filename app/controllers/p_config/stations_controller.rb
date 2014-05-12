module PConfig
  class StationsController < InheritedResources::Base
    def comprovate_ip
      #system('ping -n 4 -k 172.16.246.235')
      pt = PConfig::Station.rev_ip params[:ip_station]
      hash={}
      hash[:ping] = pt.ping?
      render :json => hash.to_json
    end
  end
end
