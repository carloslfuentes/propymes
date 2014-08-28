module PConfig
  class LineSetStation < ActiveRecord::Base
    # attr_accessible :title, :body
    belongs_to :station
    belongs_to :line_set
  end
end
