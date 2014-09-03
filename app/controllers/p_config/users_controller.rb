module PConfig
  class UsersController < InheritedResources::Base
    
    def index
      if params[:user_type] == "is_manager"
        @users = PConfig::User.is_manager
      else
        @users = PConfig::User.is_operator
      end
    end
    
    def edit
      @user = User.find_by_id params[:id]
      @array_name = @user.roles.map{|r| r.title} 
    end
    
    def update
      @user = User.find_by_id params[:id]
      @user.roles.destroy_all
      update!
    end
    
    def new
      @user = PConfig::User.new
      @person = PConfig::Person.new
      @array_name = []
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
    
  end
end
