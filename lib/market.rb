class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.filter_map { |vendor| vendor if vendor.inventory.keys.include?(item) }
  end

  def sorted_item_list
    @vendors.flat_map { |vendor| vendor.inventory.keys.map(&:name) }.uniq.sort
  end

  def total_inventory
    item_quantity = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.map do |item, quantity|
        item_quantity[item] += quantity
      end
    end

    total_inventory = {}
    item_quantity.each do |item, quantity|
      quantity_vendors = {}
      quantity_vendors["quantity"] = quantity
      quantity_vendors["vendors"] = vendors_that_sell(item)
      total_inventory[item] = quantity_vendors
    end
    total_inventory
  end

  def overstocked_items
    items = []
    total_inventory.each do |item|
      quantity = item[1]["quantity"]
      number_of_vendors = item[1]["vendors"].count
      items << item[0] if quantity > 50 && number_of_vendors > 1
    end
    items
  end
end
