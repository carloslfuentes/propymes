module PConfig
  class Event < ActiveRecord::Base
    belongs_to :station
    belongs_to :stoppage
    belongs_to :stoppage_by_category
  end
end