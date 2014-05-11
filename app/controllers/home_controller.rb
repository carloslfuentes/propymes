class HomeController < ApplicationController
  
  def index
    if current_user.is_manager?
      redirect_to manager_path
    else
      redirect_to operator_path
    end
  end
  
  def operator
    
  end
  
  def manager
    
  end

end
