class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_user_session#,  :logged_in?, :current_user_is_admin?
  before_filter :require_authentification, :set_user_language, :set_current_user
  filter_access_to :all
  
  def permission_denied
    logger.info "Permision Denied.........."
    #This line is because if you don't have permission always shows the message in english instead of in the language of the current user wants
    set_user_language
    flash[:error] = t :priviledge_error
    respond_to do |format|
      format.html { redirect_to(:back) rescue redirect_to('/home') }
      format.xml  { head :unauthorized }
      format.js   { head :unauthorized }
    end
  end
  
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
    set_user_language
    unless current_user
      #store_location
      flash[:notice] = t :authentification_required
      redirect_to new_p_config_user_session_path
      #return false
    end
  end
  
end
