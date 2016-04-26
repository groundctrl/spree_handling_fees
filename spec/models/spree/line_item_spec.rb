require "spec_helper"

RSpec.describe Spree::LineItem, type: :model do
  context "with default handling fee" do
    it "creates line_item with default (0.0) handling fee" do
      variant = create(:variant)
      item = create(:line_item, variant: variant)

      expect(item.handling_fee).to eq 0.0
    end
  end

  context "with custom handling fee" do
    it "creates line_item with custom handling fee" do
      variant = create(:variant, handling_fee: 2.15)
      item = create(:line_item, variant: variant)

      expect(item.handling_fee).to eq 2.15
    end
  end
end
