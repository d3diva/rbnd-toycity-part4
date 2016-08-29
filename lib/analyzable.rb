require_relative 'count_by'

module Analyzable

  def average_price(products)
    (products.inject(0) {|sum, el| sum + el.price.to_f} / products.size).round(2)
  end

  def print_report(all)
    all.to_s
  end
end
