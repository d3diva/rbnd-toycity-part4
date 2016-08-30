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

  #returns average price for a given brand
  #def report_average_price(key)
  #  self.class.average_price(Product.where(brand: key.to_s))
  #end

  ## returns price of a given product
  #def name_average_price(name)
  #  all_names = Product.where(name: name)
  #end

  #prints brand report with brand, quantity and average price
  def brand_report
    display_average_price(average_price(Product.all))
    by_brand = count_by_brand(Product.all)
    display_title("Brand wise Inventry Report")
    display_header("Name to the Brand", "Quantity")
    by_brand.each do |key, value|
      display_items(key, value)
    end
    print_line
    puts ""
  end

  #prints product report with product name, quantity and price
  def report_by_name
    by_brand = count_by_name(Product.all)
    display_title("Name wise Inventry Report")
    display_header("Name to the Product", "Quantity")
    by_brand.each do |key, value|
      display_items(key, value)
    end
    print_line
  end

  def print_report(all)
    report = ""
    brand_report
    report_by_name
    report.to_s
  end
end
