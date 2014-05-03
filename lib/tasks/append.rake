# encoding: utf-8

namespace :append do
  
  desc "Add states"
  task :add_states => :environment do
    puts "Adding states"
    states=["Aguascalientes","Baja California","Baja California Sur","Campeche","Chiapas","Chihuahua","Coahuila","Colima","Durango","Guanajuato","Guerrero","Hidalgo","Jalisco","Michoacán","Morelos","México","Nayarit","Nuevo León","Oaxaca","Puebla","Querétaro","Quintana Roo","San Luis Potosí","Sinaloa","Sonora","Tabasco","Tamaulipas","Tlaxcala","Veracruz","Yucatán","Zacatecas"]
    states.each do |state|
      if (model_state = State.find_by_name(state))
        model_state.update_attributes(:option_type => state)
        puts "Actualizo"
      else
       puts "Creo nuevo"
       State.create(:name => state)
      end
    end
  end
  
  desc "Add configuration"
  task :add_configuration => :environment do
    puts "Processing configurations"
    if (config_ad_type = ConfigurationValue.find_by_name_and_group("Validate Insurances","Validates"))
      config_ad_type.update_attributes(:option_type => "combo", :options => "YES|NO")
      puts "Actualizo"
    else
     puts "Creo nuevo"
     ConfigurationValue.create(:group => "Validates", :name => "Validate Insurances", :value => "NO", :option_type =>"combo", :options => "YES|NO")
    end
  end
  
  desc "Add permissions"
  task :add_permissions => :environment do
    puts "Processing"
    permission=[]
    permission << {:name=>"system",:description=>"System User"}
    permission << {:name=>"medic",:description=>"Medics"}
    permission << {:name=>"assistent",:description=>"Assistants"}
    permission << {:name=>"manager",:description=>"Managers"}
    permission << {:name=>"medical_representative",:description=>"Medical Representative"}
    permissions.each do |permission|
      puts permission[:name]
      Permission.find_or_create_by_name(permission[:name]).update_attributes(permission)
    end
  end
  
  desc "Add payment_method"
  task :add_payment_method => :environment do
    puts "Processing"
    paymetn_methods=[]
    paymetn_methods << {:name=>"insurance",:description=>"Insurance"}
    paymetn_methods << {:name=>"cash",:description=>"Cash"}
    paymetn_methods << {:name=>"credit_card",:description=>"Credit Card"}
    paymetn_methods << {:name=>"check",:description=>"Check"}
    paymetn_methods.each do |paymetn_method|
      puts paymetn_method[:name]
      PaymentMethod.find_or_create_by_name(paymetn_method[:name]).update_attributes(paymetn_method)
    end
  end
end