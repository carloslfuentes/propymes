module PConfig
  class UserSessionsController < ApplicationController
    skip_filter :require_authentification
    protect_from_forgery :only => [:edit, :update, :destroy_session] 
    filter_access_to :index
    def new
      unless current_user
        @user_session = PConfig::UserSession.new
      else
          redirect_to home_path
      end
    end
  
    def create_session
      @user_session = PConfig::UserSession.new(params[:p_config_user_session])
      if @user_session.save
         flash[:notice] = "Entrada exitosa"
         redirect_to home_path
       else
         flash[:error] = @user_session.errors.full_messages.join(",")
         redirect_to root_path
       end
    end
  
    def destroy_session
      @user_session = PConfig::UserSession.find(params[:id])
      @user_session.destroy
      redirect_to root_path
    end
  end
end