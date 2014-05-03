module SendMails
  def self.send_email_with_attach(opt)
    #opt[:mailer_id]="El id de la configuracion de email del usuario"
    #opt[:body]= "Prueba desde sigmed"
    #opt[:email]= "carlosl.fuentes@hotmail.com"
    #opt[:document]= "Aqui va el archivo que se dea enviar como buffer"
    #opt[:current_user_name]= "El nombre de quien lo envia"
    x = UserMailer.mailer_attach opt
    x.deliver 
  end
  
  def self.send_email_with_txt(opt)
    #opt[:mailer_id]="El id de la configuracion de email del usuario"
    #opt[:body]= "Prueba desde sigmed"
    #opt[:email]= "carlosl.fuentes@hotmail.com"
    #opt[:path]= "Aqui va el path del texto qe se va a enviar en el cuerpo, tiene que ser el tecto en html"
    #opt[:current_user_name]= "El nombre de quien lo envia"
    #opts[:subject]="El titulo del email"
    x = UserMailer.mailer_txt opt
    x.deliver 
  end
  
end