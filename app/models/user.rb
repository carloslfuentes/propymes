require "date"
require "digest"
require "digest/sha1"
require "authlogic"
class User < ActiveRecord::Base
  #attr_accessible :login, :password, :password_confirmation, :crypted_password, :email
  acts_as_authentic do |c|
    c.logged_in_timeout = 10.minutes # default is 10.minutes
  end
  default_value_for         :language, "es"
  default_value_for         :verified, false
  default_value_for         :perishable_token, nil
  default_value_for         :is_enabled, true
  default_value_for         :password, "default"
  default_value_for         :password_confirmation, "default"
  
  belongs_to :organization
  has_many   :payment_methods
  has_many   :cites
  has_many   :patients
  has_many   :addresses, :foreign_key => "user_id"
  has_one    :person
  has_one    :configuration_mailer, :foreign_key => "object_id"
  has_many   :insurance
  has_many   :roles
  has_many   :services, :foreign_key => "user_id"
  has_many   :assistant_medics, :foreign_key => "medic_id"
  has_many   :my_assistants, :class_name => 'AssistantMedic', :dependent => :delete_all, :foreign_key => "medic_id"
  has_many   :my_medics, :class_name => 'AssistantMedic', :dependent => :delete_all, :foreign_key => "assistant_id"
  accepts_nested_attributes_for :addresses, :person
  attr_accessor :name
  after_initialize :load_name
  scope :only_medic, where(:is_medic=>true)
  scope :only_assitant, where(:is_assistant=>true)
  scope :is_active, where(:is_enabled=>true)
  
  #validates_presence_of :organization_id
  
  def load_name
    self.name = "#{person.name}, #{person.last_name}" if person.present?
  end
  
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end
  
end
