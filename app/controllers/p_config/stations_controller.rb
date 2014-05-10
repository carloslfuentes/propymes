module PConfig
  class StationsController < InheritedResources::Base
    def comprovate_ip
      system('ping -n 10 -k 172.16.246.235')
    end
  end
end
