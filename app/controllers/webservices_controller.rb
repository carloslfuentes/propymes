class WebservicesController < InheritedResources::Base
  
  def check_time_limit
    time_limits = TimeLimit.get_enabled_user_date(params[:organization_id],params[:date].to_date)
    hash={}
    hash[:details]={}
    if hash[:status] = time_limits.present?
      time_limit = time_limits.first
      hash[:details] = {:name => time_limit.name, 
                                 :star_date => time_limit.start_date,
                                 :end_date => time_limit.end_date,
                                 :number_sessions => time_limit.number_sessions,
                                 :status => time_limit.check_status}
    else
      hash[:details]="No tiene poliza"
    end
    render :json => hash.to_json
  end
  
end
