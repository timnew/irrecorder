require_relative './sensor'

class Recorder
  attr_reader :port
  attr_reader :records
  attr_reader :sensor

  def initialize
    @commands = {}
    @records = {}
  end

  def commands(keys)
    case keys
      when Hash
        @commands.update keys.symbolize_keys!
      when Array
        @commands.update Hash[keys.map { |k| [k, nil] }].symbolize_keys!
      else
        raise ''
    end
  end

  def port=(port)
    @port = port
    @sensor = Sensor.new @port
  end

  def record
    puts 'Connecting sensor...'.light_white
    @sensor.wait_for_ready
    puts 'Sensor is ready'.light_green

    @commands.each do |key, description|
     if description.nil?
       puts "Record #{key.to_s.light_cyan}:".light_white
     else
       puts "Record #{key.to_s.light_cyan}(#{description.light_blue}):".light_white
     end
    
     record_sequence(key)
     puts
    end
  end

  def record_sequence(key)
    try = 1

    begin
      puts "[#{key.to_s.light_cyan}] #{try.ordinalize.light_blue} #{'Time'.light_white}:"
      seq = @sensor.read_sequence

      puts seq.display_text

      @records[key] ||= seq

      if @records[key] == seq
        try += 1
      else
        try = 1
        @records[key] = nil
        print 'Sequence Mismatch. '.light_red, "Retry!\n\n".light_yellow
      end

    end until (try > 3)
  end
end
