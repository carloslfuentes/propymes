class CitesController < InheritedResources::Base
  def index
    @cites = Cite.is_enabled#.for_user_medic(current_user.id)
  end
  
  def create
    if params[:send_notification]
      @doctor = User.find_by_id(params[:user_id])
      @patient = User.find_by_id(params[:patient_id])
      if (@mailer = @doctor.configuration_mailer).present?
        SendMails::send_email_with_txt({
          :mailer_id => @mailer.id,
          :path => "cite/send_notification.txt",
          :subject => "Test",
          :current_user_name => @doctor.name,
          :email => [@doctor.email, @patient.email]
        })
      end
    end
    create!
  end
  
  def process_cite
    @doctors = User.only_medic.sort_by(&:login)
    @date_cite_hidden = params[:selected_date].present? ? params[:selected_date] : Date.today
    @date_cite_show = @date_cite_hidden.to_time
    @period_time = params[:event_duration]
    @end_cite = @date_cite_hidden.to_time + @period_time.to_i.minutes
  end
end
