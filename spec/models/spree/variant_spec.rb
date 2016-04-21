require "spec_helper"

RSpec.describe Spree::Variant, type: :model do
  after { Spree::Config.handling_fee = 0 }

  context "with default handling fee" do
    it "creates variants with default (0.0) handling fee" do
      variant = create(:base_variant)

      expect(variant.handling_fee).to eq 0.0
    end
  end

  context "with custom handling fee" do
    it "creates variants with default custom handling fee" do
      Spree::Config.handling_fee = 2.15

      variant = create(:base_variant)

      expect(variant.handling_fee).to eq 2.15
    end
  end
end
