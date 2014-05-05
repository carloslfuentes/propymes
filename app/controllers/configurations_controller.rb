class ConfigurationsController < InheritedResources::Base
  
  def index
    redirect_to home_configurations_path
  end
  
end
