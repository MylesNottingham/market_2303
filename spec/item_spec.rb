require "./lib/item"

RSpec.describe Item do
  before(:each) do
    @item_1 = Item.new({name: "Peach", price: "$0.75"})
    @item_2 = Item.new({name: "Tomato", price: "$0.50"})
  end

  describe "#initialize" do
    it "can initialize an item with attributes" do
      expect(@item_1).to be_an(Item)
      expect(@item_1.name).to eq("Peach")
      expect(@item_1.price).to eq("$0.75")
    end

    xit "can initialize another item with attributes" do
      expect(@item_2).to be_an(Item)
      expect(@item_2.name).to eq("Tomato")
      expect(@item_2.price).to eq("$0.50")
    end
  end
end
