module PConfig
  class LineSetsController < InheritedResources::Base
  	def edit
  		@line_set = PConfig::LineSet.find_by_id params[:id]
  		@array_name = @line_set.line_set_stations.map{|l| l.station_id.to_s+"|"+l.station.name+"|"+l.station.standard.try(:item_number).to_s}
  	end

  	def update
  		@line_set = PConfig::LineSet.find_by_id params[:id]
  		@line_set.line_set_stations.where(:line_set_id => params[:id]).destroy_all
  		update!
  	end
  	
  	def new
  	  @line_set = PConfig::LineSet.new
  	  @array_name = []
  	end

  end
end
