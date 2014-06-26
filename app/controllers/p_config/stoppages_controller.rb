module PConfig
  class StoppagesController < InheritedResources::Base
    
    def start_stoppages
      # [:id] ID del paro 
      # [:description] Nombre del paro
      # [:working_day_id]
      #aqui jalas compi hay que hacer relaciones.
      
      render :json => true
    end
    
  end
end
