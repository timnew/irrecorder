require_relative './sensor'

class Verifier
  attr_reader :port
  attr_reader :sensor
  attr_reader :commands

  def port=(port)
    @port = port
    @sensor = Sensor.new @port
  end

  def commands=(value)    
    items = value.map do |k,v|
      [k.to_sym, IrSequence.wrap(v)]      
    end

    @commands = Hash[items]    
  end

  def verify    
    puts 'Connecting sensor...'.light_white
    @sensor.wait_for_ready
    puts 'Sensor is ready'.light_green    
    
    result = @commands.map do |key, data|      
      [key, verify_key(key, data)]    
    end

    Hash[result]
  end

  def verify_key(key, data)
    try = 1           

    begin
      print "Verify #{key.to_s.light_cyan}: "
      seq = @sensor.read_sequence

      if(seq == data)
        puts 'Verified'.light_green        
        return true
      end
      
      puts "#{'Mismatch:'.light_red} #{try.ordinalize.light_blue} #{'Time'.light_white} ", "#{'Expecting'.light_white} #{data.display_text}" , "#{'Got'.light_white}       #{seq.display_text}", ''

      try += 1    
    end until (try > 3)

    false
  end
end
