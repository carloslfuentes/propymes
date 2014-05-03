class ConfigurationsController < InheritedResources::Base
  
  def index
    redirect_to home_configurations_path
  end
  
  def add_permissions_user
    @users = User.all
    @permissions = Permission.all
  end
  
  def create_permission_user
    user = User.find_by_id params[:user_id]
    permissions = params[:permissions].split(",")
    unless permissions.present?
      redirect_to :back
      return
    end
    roles = Role.for_user_id params[:user_id]
    roles.destroy_all if roles.present? 
    permissions.each do |permission|
      user.roles.create(:title => permission)
    end
    redirect_to configurations_path
  end
  
  def associate_assistant_doctor
    @assistants = User.only_assitant
    @medics = User.only_medic
  end
  
  def create_associate
    user = params[:user_id]
    medics = params[:medics].split(",")
    new_assiatan_medic = []
    medics.each do |medic|
      new_assiatan_medic << {:assistant_id=>user,:medic_id=>medic}
    end
    if AssistantMedic.create(new_assiatan_medic)
      redirect_to configurations_path
      return
    else
      redirect_to :back
      return
    end
  end

end
