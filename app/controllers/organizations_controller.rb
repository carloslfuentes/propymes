class OrganizationsController < InheritedResources::Base
  skip_filter :require_authentification
  
  def new
    @organization = Organization.new
    @addresses = @organization.addresses.build
  end
  
  def edit
    @organization = Organization.find_by_id params[:id]
    @addresses = @organization.addresses if @organization.addresses.build
  end
  
  def add_medicaments
    @organization = Organization.find_by_id params[:id]
    @medicaments = @organization.medicaments.build 
  end
  
  def create
    
  end
  
end
