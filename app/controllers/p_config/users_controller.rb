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
    
    def get_permission_selected
      @user = PConfig::User.find_by_id params[:user_id]
      hash=[]
      @user.roles.map{|r| hash << r.title} if @user.roles.present?
      render :json => hash.join(",").to_json
    end
    
  end
end
