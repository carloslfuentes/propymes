class UserMailer < ActionMailer::Base
  default :from => "from@example.com"
  
  def load_settings(mailer_id)
    mailer = ConfigurationMailer.find_by_id mailer_id
    ActionMailer::Base.smtp_settings = {
                :address        => mailer.address,
                :port           => mailer.port,
                :domain         => mailer.domain,
                :user_name      => mailer.user_name,
                :password       => mailer.password,
                :authentication => mailer.authentication,
                :enable_starttls_auto => mailer.enable_starttls_auto

              }
    ActionMailer::Base.perform_deliveries = true
  end
  
  def mailer_txt( opts = {} )
    load_settings(opts[:mailer_id])
    encoded_content = File.open( opts[:path] , 'rb') {|f| f.read}
    #content_type 'text/html'
    mail(:to => opts[:email], :from => opts[:current_user_name], :reply_to => 'no-reply@sigmed.com', :subject => opts[:subject], :body => encoded_content, :content_type => 'text/html')
  end
  
  def mailer_attach( opts = {} )
    load_settings(opts[:mailer_id])
    @from = opts[:current_user_name]
    encoded_content = opts[:document]
    subject = "Report ["+ Date.today.to_s + "]"
    @requestor_email = opts[:email]
    
    mail(:to => @requestor_email, :from => @from, :reply_to => 'no-reply@sigmed.com', :subject => subject) do |format|
      format.html {opts[:body]}
      format.pdf {attachments["report.pdf"] = encoded_content } 
    end
    
  end
  
end
