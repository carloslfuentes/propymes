module PConfig
  class UsersController < InheritedResources::Base
    
    def index
      if params[:user_type] == "is_manager"
        @users = PConfig::User.is_manager
      else
        @users = PConfig::User.is_operator
      end
    end
    
    def new
      @user = PConfig::User.new
      @person = PConfig::Person.new
    end
    
    def show
      @user = User.find_by_id params[:id]
    end
    
    def get_permission_selected
      @user = PConfig::User.find_by_id params[:user_id]
      hash=[]
      @user.roles.map{|r| hash << r.title} if @user.roles.present?
      render :json => hash.join(",").to_json
    end
    
    def get_assosiate_assitant
      @user = PConfig::User.find_by_id params[:user_id]
      hash=[]
      @user.my_medics.map{|m| hash << m.medic_id} if @user.my_medics.present?
      render :json => hash.join(",").to_json
    end
    
  end
end
