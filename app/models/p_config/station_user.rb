module PConfig
  class StationUser < ActiveRecord::Base
    # attr_accessible :title, :body
    belongs_to :station
    belongs_to :user
  end
end