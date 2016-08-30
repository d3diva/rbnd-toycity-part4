module Report

  def print_line
    puts "-" * 50
  end

  def display_title(title)
    puts "#{(title)}".upcase.yellow
  end

  def display_average_price(avg_price)
    print_line
    puts "Average Price : #{avg_price}".red
    print_line
  end

  def display_header(type, quantity)
    print_line
    puts "#{type.ljust(28)} #{quantity}".capitalize.green
    print_line
  end

  def display_items(key, value)
    puts "#{key.ljust(30)} #{value.to_s}"
  end



end
