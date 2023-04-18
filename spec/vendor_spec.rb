require "./lib/item"
require "./lib/vendor"

RSpec.describe Vendor do
  before(:each) do
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @item_1 = Item.new({ name: "Peach", price: "$0.75" })
    @item_2 = Item.new({ name: "Tomato", price: "$0.50" })
    @item_3 = Item.new({ name: "Peach-Raspberry Nice Cream", price: "$5.30" })
    @item_4 = Item.new({ name: "Banana Nice Cream", price: "$4.25" })
  end

  describe "#initialize" do
    it "can initialize a vendor with attributes" do
      expect(@vendor_1).to be_a(Vendor)
      expect(@vendor_1.name).to eq("Rocky Mountain Fresh")
      expect(@vendor_1.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it "has zero items in inventory by default" do
      expect(@vendor_1.check_stock(@item_1)).to eq(0)
    end
  end

  describe "#stock" do
    it "can add a given quantity of an item to inventory" do
      expect(@vendor_1.check_stock(@item_1)).to eq(0)
      @vendor_1.stock(@item_1, 30)
      expect(@vendor_1.inventory).to eq({ @item_1 => 30 })
      expect(@vendor_1.check_stock(@item_1)).to eq(30)
    end

    it "can add more of a given quantity of an item to inventory" do
      expect(@vendor_1.check_stock(@item_1)).to eq(0)
      @vendor_1.stock(@item_1, 30)
      expect(@vendor_1.inventory).to eq({ @item_1 => 30 })
      expect(@vendor_1.check_stock(@item_1)).to eq(30)
      @vendor_1.stock(@item_1, 25)
      expect(@vendor_1.inventory).to eq({ @item_1 => 55 })
      expect(@vendor_1.check_stock(@item_1)).to eq(55)
    end

    it "can add a given quantity of another item to inventory" do
      @vendor_1.stock(@item_1, 55)
      expect(@vendor_1.check_stock(@item_2)).to eq(0)
      @vendor_1.stock(@item_2, 30)
      expect(@vendor_1.check_stock(@item_2)).to eq(30)
      expect(@vendor_1.inventory).to eq({ @item_1 => 55, @item_2 => 30 })
    end
  end

  describe "#potential_revenue" do
    it "can return the value of all items in inventory" do
      @vendor_1.stock(@item_1, 35)
      @vendor_1.stock(@item_2, 7)
      @vendor_2.stock(@item_4, 50)
      @vendor_2.stock(@item_3, 25)
      @vendor_3.stock(@item_1, 65)

      expect(@vendor_1.potential_revenue).to eq(29.75)
      expect(@vendor_2.potential_revenue).to eq(345.00)
      expect(@vendor_3.potential_revenue).to eq(48.75)
    end
  end
end
