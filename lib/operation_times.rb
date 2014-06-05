module OperationTimes
  module Sum
    def self.basic(params1,params2)
      params1 = params1.strftime("%H:%M:%S") if params1.class.to_s == "Time"
      params2 = params2.strftime("%H:%M:%S") if params2.class.to_s == "Time"
      ar = params2.split(":")
      return (Time.parse(params1) + ar[0].to_i.hour + ar[1].to_i.minute + ar[2].to_i.second).strftime("%H:%M:%S")
    end
  end
  module Deduct
    def self.basic(params1,params2)
      params1 = params1.strftime("%H:%M:%S") if params1.class.to_s == "Time"
      params2 = params2.strftime("%H:%M:%S") if params2.class.to_s == "Time"
      ar = params2.split(":")
      return (Time.parse(params1) - ar[0].to_i.hour - ar[1].to_i.minute - ar[2].to_i.second).strftime("%H:%M:%S")
    end
  end
  
end