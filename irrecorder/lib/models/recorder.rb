require_relative './sensor'

class Recorder
  attr_accessor :port
  attr_reader :records

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

  def record
    begin
      sensor = Sensor.new @port, baud_rate: 9600, data_bits: 8, stop_bits: 1, parity: SerialPort::NONE
    rescue error
      raise "Failed to open port #{port}.\n#{error}"
    end

    begin
      #puts 'Connecting sensor...'.light_white
      sensor.wait_for_ready
      puts 'Sensor is ready'.light_green
    rescue error
      raise error
    end

    @commands.each do |key, description|
      if description.nil?
        puts "Record #{key}:".light_white
      else
        puts "Record #{key}(#{description}):".light_white
      end

      record_sequence(sensor, key)
    end
  end

  def record_sequence(sensor, key)
    try = 1

    begin
      puts "#{try.ordinalize} Time:".light_white
      seq = sensor.read_sequence

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
