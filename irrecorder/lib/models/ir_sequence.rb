module IrSequence
  def display_text
    "#{type.light_yellow}:#{value.light_green}(#{size.light_blue})"
  end

  def type
    self[:type]
  end

  def value
    self[:value]
  end

  def size
    self[:size]
  end
end