require "./lib/item"
require "./lib/vendor"

RSpec.describe Vendor do
  before(:each) do
    @vendor = vendor = Vendor.new("Rocky Mountain Fresh")
    @item_1 = Item.new({name: "Peach", price: "$0.75"})
    @item_2 = Item.new({name: "Tomato", price: "$0.50"})
  end

  describe "#initialize" do
    it "can initialize a vendor with attributes" do
      expect(@vendor).to be_a(Vendor)
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it "has zero items in inventory by default" do
      expect(@vendor.check_stock(@item_1)).to eq(0)
    end
  end

  describe "#stock" do
    it "can add a given quantity of an item to inventory" do
      expect(@vendor.check_stock(@item_1)).to eq(0)
      @vendor.stock(@item_1, 30)
      expect(@vendor.inventory).to eq({@item_1 => 30})
      expect(@vendor.check_stock(@item_1)).to eq(30)
    end

    it "can add more of a given quantity of an item to inventory" do
      expect(@vendor.check_stock(@item_1)).to eq(0)
      @vendor.stock(@item_1, 30)
      expect(@vendor.inventory).to eq({@item_1 => 30})
      expect(@vendor.check_stock(@item_1)).to eq(30)
      @vendor.stock(@item_1, 25)
      expect(@vendor.inventory).to eq({@item_1 => 55})
      expect(@vendor.check_stock(@item_1)).to eq(55)
    end

    it "can add a given quantity of another item to inventory" do
      @vendor.stock(@item_1, 55)
      expect(@vendor.check_stock(@item_2)).to eq(0)
      @vendor.stock(@item_2, 30)
      expect(@vendor.check_stock(@item_2)).to eq(30)
      expect(@vendor.inventory).to eq({@item_1 => 55, @item_2 => 30})
    end
  end
end
