require "./lib/item"
require "./lib/vendor"
require "./lib/market"

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @item_1 = Item.new({name: "Peach", price: "$0.75"})
    @item_2 = Item.new({name: "Tomato", price: "$0.50"})
    @item_3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item_4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor_1.stock(@item_1, 35)
    @vendor_1.stock(@item_2, 7)
    @vendor_2.stock(@item_4, 50)
    @vendor_2.stock(@item_3, 25)
    @vendor_3.stock(@item_1, 65)
  end

  describe "#initialize" do
    it "can initialize a market with attributes" do
      expect(@market).to be_a(Market)
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

  describe "#add_vendor" do
    it "can add vendors to vendors" do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor_1)
      expect(@market.vendors).to eq([@vendor_1])
      @market.add_vendor(@vendor_2)
      expect(@market.vendors).to eq([@vendor_1, @vendor_2])
      @market.add_vendor(@vendor_3)
      expect(@market.vendors).to eq([@vendor_1, @vendor_2, @vendor_3])
    end
  end

  describe "#vendor_names" do
    it "can return the names of all vendors as an array" do
      @market.add_vendor(@vendor_1)
      @market.add_vendor(@vendor_2)
      @market.add_vendor(@vendor_3)
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors_that_sell" do
    it "can return an array of vendors that sell an item" do
      @market.add_vendor(@vendor_1)
      @market.add_vendor(@vendor_2)
      @market.add_vendor(@vendor_3)

      expect(@market.vendors_that_sell(@item_1)).to eq([@vendor_1, @vendor_3])
      expect(@market.vendors_that_sell(@item_4)).to eq([@vendor_2])
    end
  end

  describe "#sorted_item_list" do
    it "can return an array of the names of all items vendors have in stock" do
      @market.add_vendor(@vendor_1)
      @market.add_vendor(@vendor_2)
      @market.add_vendor(@vendor_3)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe "#total_inventory" do
    it "can return a hash in a hash" do
      @market.add_vendor(@vendor_1)
      @market.add_vendor(@vendor_2)
      @market.add_vendor(@vendor_3)

      expect(@market.total_inventory).to eq(
        {
          @item_4 => { 50 => [@vendor_2] },
          @item_3 => { 25 => [@vendor_2] },
          @item_2 => { 7 => [@vendor_1] },
          @item_1 => { 100 => [@vendor_1, @vendor_3] }
        }
      )
    end
  end

  describe "#overstocked_items" do
    it "can return an array of overstocked items" do
      @market.add_vendor(@vendor_1)
      @market.add_vendor(@vendor_2)
      @market.add_vendor(@vendor_3)

      expect(@market.overstocked_items).to eq([@item_1])
    end
  end
end
