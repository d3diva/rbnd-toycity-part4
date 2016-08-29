module Analyzable
  # Your code goes here!

  def count_by_brand(products)
    brand = {}
    #products.each do |product|
    #    brand[product.brand] == nil ? brand[product.brand] = 1 : brand[product.brand] += 1
    #end
    brand = products.each { |product| brand[.product.brand].nil ? brand[.product.brand] = 1 : brand[.product.brand] +=1 }
  end

  def count_by_name(products)
    name = {}
    products.each
  end

  def average_price(products)
    (products.inject(0) {|sum, el| sum + el.price.to_f} / products.size).round(2)
  end

  def print_report(all)
    all.to_s
  end
end
