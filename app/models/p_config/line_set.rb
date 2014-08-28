module PConfig
  class LineSet < ActiveRecord::Base
    # attr_accessible :title, :body
    has_many    :line_set_stations, :dependent => :delete_all
    has_many    :station, :through => :line_set_stations
    accepts_nested_attributes_for :line_set_stations
  end
end
