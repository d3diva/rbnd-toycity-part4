module Report

  def print_line
    puts "-" * 70
  end

  def display_title(title)
    puts
    puts "#{(title)}".upcase.yellow
    puts
  end

  def display_header(type, quantity, average_price)
    print_line
    puts "#{type.ljust(30)} #{quantity.ljust(20)} #{average_price}".capitalize.green
    print_line
  end

  def display_items(key, value, average_price)
    puts "#{key.ljust(30)} #{value.to_s.ljust(20)} #{average_price}"
  end



end
