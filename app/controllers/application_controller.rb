class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_user_session#,  :logged_in?, :current_user_is_admin?
  before_filter :require_authentification, :set_user_language, :set_current_user
  #filter_access_to :all
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = PConfig::UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    login_with_access_token
    @current_user = current_user_session && current_user_session.record
  end
  
  def set_current_user
    if current_user 
      Authorization.current_user = current_user
      #Thread.current['user'] = current_user
    else
      Authorization.current_user = nil
      #Thread.current['user'] = nil      
    end
  end
  
  def login_with_access_token
    return if params[:user_credentials].nil?
    logger.info "login_with_access_token = "+ params[:user_credentials]
    user = PConfig::User.find_by_single_access_token(params[:user_credentials])
    PConfig::UserSession.create(user) if(user.present?)
  end
  
  def set_user_language
    if current_user
      I18n.locale=current_user.language
    else
      I18n.locale="es"
    end
  end
  
  def require_authentification 
    unless current_user
      #store_location
      flash[:notice] = t :authentification_required
      redirect_to new_user_session_path
      #return false
    end
  end
  
  private
  def check_time_limit
    if current_user
      limit = current_user.organization.nullo.time_limit.if_nil([])
      if limit.present?
        if limit.next_check < Time.now
          limit.next_check = (Time.now + 24.hour)
          return_time_limit = WebService::AutenticationLimitTime.check_time_limit(current_user.organization.id)
          if return_time_limit[:status]
            detail = return_time_limit[:detail]
            limit.start_date = detail["start_date"]
            limit.end_date = detail["end_date"]
            limit.number_sessions = detail["number_sessions"]
            limit.status = detail["status"]
          end
          limit.save
        end
      else
        
      end
    end
  end
  
end
