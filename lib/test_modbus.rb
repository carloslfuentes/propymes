require 'rmodbus'
module TestModbus
  def self.run_modbus(ip,port,slave_number,code)
     ModBus::TCPClient.new(ip, port) do |cl|
      cl.with_slave(slave_number) do |slave|
        puts slave.holding_registers[code]
      end
    end
  end
end
