# encoding: utf-8

namespace :append do
  
  desc "Add permissions"
  task :add_permissions => :environment do
    puts "Processing"
    permissions=[]
    permissions << {:name=>"default",:description=>"operators"}
    permissions << {:name=>"system",:description=>"sistemas"}
    permissions.each do |permission|
      puts permission[:name]
      Permission.find_or_create_by_name(permission[:name]).update_attributes(permission)
    end
  end
  
end