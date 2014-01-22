require 'io/console'
require_relative './sensor'

class Revealer
  attr_reader :port
  attr_reader :sensor 

  def port=(port)
    @port = port
    @sensor = Sensor.new @port
  end

  def reveal
    puts 'Connecting sensor...'.light_white
    @sensor.wait_for_ready
    puts 'Sensor is ready'.light_green        

    Thread.new do
      index = 0
      loop do
        index += 1
        print index.to_s.light_white, ': ', @sensor.read_sequence.display_text, "\r\n"
      end
    end

    puts 'Press any key to abort...'.light_yellow
    
    STDIN.getch
  end
end
