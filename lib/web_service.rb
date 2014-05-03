require 'net/http'
module WebService
  module AutenticationLimitTime
    def self.check_time_limit(organization_id)
      #FIXME configurar este url cuando ya se tenga las configuracions
      host = "192.168.0.5:3000"
      credentials = "oj47VQil4OlV47gWj7"
      begin
        url = "http://#{host}/webservices/check_time_limit?organization_id=#{organization_id}&date=#{Date.today}&user_credentials=#{credentials}"
        resp = Net::HTTP.get_response(URI.parse(url))
        data = resp.body
        hash = JSON.parse(data)
      rescue  
        return {:status=>false,:detail=>"Error Conexion"}
      end  
      return {:status=>false,:detail=>hash["details"]} unless hash["status"]
      array_detaisl = []
      #(1 .. hash["details"].count).each do |sa|
      #  array_detaisl << hash["details"][(sa-1).to_s]
      #end
      return {:status=>hash["status"],:detail=>hash["details"]}
    end
  end
end