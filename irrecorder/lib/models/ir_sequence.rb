module IrSequence
  def self.wrap(data)
    data.symbolize_keys!.extend self
  end

  def self.extended(obj)
    obj[:type] = obj[:type].to_sym rescue obj[:type]
  end

  def display_text
    type_text = type.to_s.light_yellow
    value_text = "0x#{code.to_s(16).upcase}".light_green
    size_text = length.to_s.light_blue
    "#{type_text}:#{value_text}(#{size_text})"
  end

  def type
    self[:type]
  end

  def code
    self[:code]
  end

  def length
    self[:length]
  end
end