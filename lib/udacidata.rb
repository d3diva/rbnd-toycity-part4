require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
@@data_path = File.dirname(__FILE__)+"/../data/data.csv"

  def self.create(attributes={})
    new_item = self.new(attributes)
    CSV.open(@@data_path, "a+") do |csv|
      csv << [new_item.id, new_item.brand, new_item.name, new_item.price]
    end
    new_item
  end

  def self.all
    #data = CSV.read(@@data_path, headers: true)
    #data.map { |item| self.new(id: item["id"], brand: item["brand"], name: item["product"], price: item["price"])}
    all_products = []
    CSV.foreach(@@data_path, headers: true) do |row|
      all_products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    all_products
  end

  def product_not_found(item)
    raise ProductNotFoundErrors, "Error : '#{item}' does not Exist"
  end

  def self.first(item = nil)
    item ? all.first(item) : all.first
  end

  def self.last(item = nil)
    item ? all.last(item) : all.last
  end

  def self.find(item)
    found_item = all.find { |e| e.id == item}
    found_item == nil ? product_not_found(item) : found_item
  end

  def self.open_data
    CSV.table(@@data_path)
  end

  def self.update_date(all_items)
    File.open(@@data_path, 'w+') do |f|
      f.write(all_items.to_csv)
    end
  end

  def self.found_item_delete(item)
    all_items = open_data
    all_items.delete(item)
    update_date(all_items)
  end

  def self.destroy(item)
    to_be_deleted = find(item)
    to_be_deleted ? found_item_delete(item) : product_not_found(item)
    to_be_deleted
  end

  def self.where(val)
    #all.select { |item| item.brand == options[:brand]}
    where_found = all.select! { |item| item.send(val.keys.first) == val.values.first}
  end

  def update(options={})
      #Product.create(*attributes) if Product.destroy(Product.find(@id).id)
      item = Product.find(@id)
      item.brand.replace(options[:brand]) if options[:brand]
      item.name.replace(options[:name])if options[:name]
      item.price.replace(options[:price].to_s) if options[:price]
      Product.destroy(@id)
      Product.create(id: @id, brand: item.brand, name: item.name, price: item.price.to_f)
  end


end
