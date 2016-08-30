require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
@@data_path = File.dirname(__FILE__)+"/../data/data.csv"

  # adds new records
  def self.create(attributes={})
    new_item = self.new(attributes)
    CSV.open(@@data_path, "a+") do |csv|
      csv << [new_item.id, new_item.brand, new_item.name, new_item.price]
    end
    new_item
  end

  # pushes all record to all_products
  def self.all
    all_products = []
    CSV.foreach(@@data_path, headers: true) do |row|
      all_products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    all_products
  end

  # product not found errror
  def product_not_found(item)
    raise ProductNotFoundErrors, "Error : '#{item}' does not Exist"
  end

  #returns first record or first few requred numbers of records
  def self.first(item = nil)
    item ? all.first(item) : all.first
  end

  #returns last record or last few requred numbers of records
  def self.last(item = nil)
    item ? all.last(item) : all.last
  end

  # finds record with id
  def self.find(item)
    found_item = all.find { |e| e.id == item}
    found_item == nil ? product_not_found(item) : found_item
  end

  #opens csv file
  def self.open_data
    CSV.table(@@data_path)
  end

  #updates csv file with given records
  def self.update_date(all_items)
    File.open(@@data_path, 'w+') do |f|
      f.write(all_items.to_csv)
    end
  end

  #delete record with id
  def self.found_item_delete(item)
    all_items = open_data
    all_items.delete(item)
    update_date(all_items)
  end

  # destroyes record
  def self.destroy(item)
    to_be_deleted = find(item)
    to_be_deleted ? found_item_delete(item) : product_not_found(item)
    to_be_deleted
  end

  # finds records with brand or name
  def self.where(options={})
    if options[:brand]
      items = all.select { |item| item.brand == options[:brand]}
    elsif options[:name]
      items = all.select { |item| item.name == options[:name]}
    end
    return items
  end

  # updates records with given values
  def update(options={})
      item = self.class.find(@id)
      item.brand.replace(options[:brand]) if options[:brand]
      item.name.replace(options[:name])if options[:name]
      item.price.replace(options[:price].to_s) if options[:price]
      self.class.destroy(@id)
      self.class.create(id: @id, brand: item.brand, name: item.name, price: item.price.to_f)
  end


end
