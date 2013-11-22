require_relative './ir_sequence'

class Sensor < SerialPort
  def read_sequence
    puts 'Sequence?'
    data = gets
    JSON.parse(data).symbolize_keys!.extend(IrSequence)
  end

  def wait_for_ready
    self.puts "Ready?\n"
    data = self.gets.strip!

    raise 'Sensor Error' unless data == 'SENSOR:OK'
  end
end