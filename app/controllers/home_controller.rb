class HomeController < ApplicationController
  
  def index
    @cites = Cite.is_enabled.for_user_medic(current_user.id)
    @medics = current_user.my_medics
    #@return = WebService::AutenticationLimitTime.check_time_limit(current_user.id)
    #unless @return[:status]
      #flash[:warning] = @return[:detail]
    #else
      #flash[:warning] = @return[:detail].join(",")
    #end
  end

end
