class ServicesController < InheritedResources::Base
  def get_services
    @services = Service.where(params[:type].to_sym => params[:id])
    hash={}
    hash[:rate_service_service_id] = @services.map{|p| [p.name,p.id]} if @services.present?
    render :json => hash.to_json
  end
end
