require "spec_helper"

RSpec.describe Spree::TaxRate, type: :model do
  context "with handling fee tax" do
    it "creates variants with default (0.0) handling fee" do
      tax_rate = create(:handling_fee_tax, amount: "1")

      expect(tax_rate.amount).to eq 0
      expect(tax_rate.included_in_price).to be_falsey
      expect(tax_rate.show_rate_in_label).to be_falsey
    end
  end
end
