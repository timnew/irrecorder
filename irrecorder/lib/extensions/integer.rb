class Integer
  def ordinalize
    if (11..13).include?(to_i.abs % 100)
      "#{self}th"
    else
      case to_i.abs % 10
        when 1;
          "#{self}st"
        when 2;
          "#{self}nd"
        when 3;
          "#{self}rd"
        else
          "#{self}th"
      end
    end
  end
end
