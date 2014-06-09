module PConfig
  class StandardsController < InheritedResources::Base
    def new
      @product = PConfig::Product.find_by_id params[:product_id]
      @standard = @product.standards.build
    end
    
    def create
      if @standard = PConfig::Standard.create(params[:p_config_standard])
        redirect_to p_config_product_standard_path(@standard.product_id,@standard.id)
      else
        redirect_to :back
      end
    end
    
    def update
      @standard = PConfig::Standard.find_by_id params[:id]
      if @standard.update_attributes(params[:p_config_standard])
        redirect_to p_config_product_standard_path(@standard.product_id,@standard.id)
      else
        redirect_to :back
      end
    end
  end
end
