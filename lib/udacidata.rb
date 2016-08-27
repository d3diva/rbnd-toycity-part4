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
    data = CSV.read(@@data_path, headers: true)
    @@all_items = data.map { |item| self.new(id: item["id"], brand: item["brand"], name: item["product"], price: item["price"])}
    #@@products = []
    #CSV.read(@@data_path, headers: true).each do |product|
    #  @@products << self.new(id: product["id"], brand: product["brand"], name: product["product"], price: product["price"])
    #end
    ##@@products.each { |e| puts "#{e.id} -- #{e.brand} -- #{e.name} -- #{e.price} "  }
    #all_items
  end

  def self.first(item = nil)
    item ? all.first(item) : all.first
  end

  def self.last(item = nil)
    item ? all.last(item) : all.last
  end

  def self.find(item)
    all.find { |e| e.id == item}
  end

  def self.destroy(item)
    to_be_deleted = find(item)
    all_items = CSV.table(@@data_path)
    all_items.delete_if { |e| e[:id] == item}
    File.open(@@data_path, 'w+') do |f|
      f.write(all_items.to_csv)
    end
    to_be_deleted
  end

  def self.where(options ={})
    all.select { |item| item.brand == options[:brand]}
  end

  def self.update(options = )

  end

end
