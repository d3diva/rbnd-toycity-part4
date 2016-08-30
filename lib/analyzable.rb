require_relative 'count_by'
require 'artii'
require 'colorize'
require_relative 'report'
include Report

module Analyzable
  # returns average price of given products
  def average_price(products)
    (products.inject(0) {|sum, el| sum + el.price.to_f} / products.size).round(2)
  end

  #prints brand report with brand, quantity and average price
  def brand_report(all)
    display_average_price(average_price(all))
    by_brand = count_by_brand(all)
    display_title("Brand wise Inventry Report")
    display_header("Name to the Brand", "Quantity")
    by_brand.each do |key, value|
      display_items(key, value)
    end
    print_line
    puts ""
  end

  #prints product report with product name, quantity and price
  def report_by_name(all)
    by_brand = count_by_name(all)
    display_title("Name wise Inventry Report")
    display_header("Name to the Product", "Quantity")
    by_brand.each do |key, value|
      display_items(key, value)
    end
    print_line
  end

  def print_report(all)
    report = ""
    brand_report(all)
    report_by_name(all)
    report.to_s
  end
end
