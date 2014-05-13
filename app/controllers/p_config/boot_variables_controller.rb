module PConfig
  class BootVariablesController < InheritedResources::Base
    
    def new
      if params[:object_id].present?
        @boot_variable = PConfig::BootVariable.find_by_id(params[:object_id])
        @boot_variable.clone
      else
        @boot_variable = PConfig::BootVariable.new
      end
    end
  end
end