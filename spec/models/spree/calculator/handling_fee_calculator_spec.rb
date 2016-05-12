require "spec_helper"

describe Spree::Calculator::HandlingFeeCalculator, type: :model do
  let!(:country) { create(:country) }
  let!(:zone) do
    create(:zone, name: "Country Zone", default_tax: true, zone_members: [])
  end
  let!(:tax_category) { create(:tax_category, tax_rates: []) }
  let!(:rate) { create(:handling_fee_tax, tax_category: tax_category) }
  let!(:calculator) do
    Spree::Calculator::HandlingFeeCalculator.new(calculable: rate)
  end
  let!(:order) { create(:order) }
  let!(:variant) { create(:master_variant, handling_fee: 3.14) }
  let!(:line_item) do
    create(:line_item, price: 10,
                       quantity: 2,
                       tax_category: tax_category,
                       variant: variant)
  end
  let!(:shipment) { create(:shipment, cost: 15) }

  let!(:variant2) { create(:master_variant, handling_fee: 0.30) }

  context "#compute" do
    it "raises an error" do
      expect { subject.compute(order) }.to raise_error(
        "Spree::Calculator::HandlingFeeCalculator is designed to " \
        "calculate taxes at the line-item level."
      )
    end
  end

  context "#compute_order" do
    it "raises an error" do
      expect { subject.compute(order) }.to raise_error(
        "Spree::Calculator::HandlingFeeCalculator is designed to " \
        "calculate taxes at the line-item level."
      )
    end

    it "raises an error" do
      expect { subject.compute_order(order) }.to raise_error(
        "Spree::Calculator::HandlingFeeCalculator is designed to " \
        "calculate taxes at the line-item level."
      )
    end
  end

  context "#compute_shipment" do
    it "raises an error" do
      expect { subject.compute_shipment(order) }.to raise_error(
        "Spree::Calculator::HandlingFeeCalculator is designed to " \
        "calculate taxes at the line-item level."
      )
    end
  end

  context "#compute_line_item" do
    it "should be equal to the item's handling fee * quantity" do
      expect(calculator.compute(line_item)).to eq 6.28
    end
  end

  context "when given a line_item" do
    let(:rate) { create(:handling_fee_tax) }
    let(:variant) { create(:master_variant, handling_fee: 2.15) }
    let(:line_item) { create(:line_item, quantity: 10, variant: variant) }

    subject do
      Spree::Calculator::HandlingFeeCalculator.new(calculable: rate)
                                              .compute_line_item(line_item)
    end

    describe "#compute_line_item" do
      it "computes the line item right" do
        Spree::TaxRate.store_pre_tax_amount(line_item, [rate])

        expect(subject).to eq 21.50
      end
    end
  end
end
