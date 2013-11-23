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

    #@commands.each do |key, description|
    #  if description.nil?
    #    puts "Record #{key}:".light_white
    #  else
    #    puts "Record #{key}(#{description}):".light_white
    #  end
    #
    #  record_sequence(key)
    #end
  end

  def record_sequence(key)
    try = 1

    begin
      puts "Button [#{key}] #{try.ordinalize} Time:".light_white
      seq = @sensor.read_sequence

      puts seq.display_text

      @records[key] ||= seq

      if @record[key] == seq
        try += 1
      else
        try = 1
        print 'Sequence Mismatch. '.light_red, "Retry!\n\n".light_white
      end

    end until (try > 3)
  end
end
