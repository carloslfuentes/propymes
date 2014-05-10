require "date"
require "digest"
require "digest/sha1"
require "authlogic"
module PConfig
  class User < ActiveRecord::Base
    #attr_accessible :login, :password, :password_confirmation, :crypted_password, :email
    acts_as_authentic do |c|
      c.logged_in_timeout = 10.minutes # default is 10.minutes
      c.session_class = Session
    end
    default_value_for         :language, "es"
    default_value_for         :verified, false
    default_value_for         :perishable_token, nil
    default_value_for         :is_enabled, true
    default_value_for         :password, "default"
    default_value_for         :password_confirmation, "default"
    
    has_one    :person
    has_one    :configuration_mailer, :foreign_key => "object_id"
    has_many   :roles
    #belongs_to :station,  :name_class=>'PConfig::Station',:foreign_key => "station_id"
    
    accepts_nested_attributes_for :person
    attr_accessor :name
    after_initialize :load_name
    
    scope :is_active, where(:is_enabled=>true)
    
    def load_name
      self.name = "#{person.name}, #{person.last_name}" if person.present?
    end
    
    def role_symbols
      (roles || []).map {|r| r.title.to_sym}
    end
    
  end
end