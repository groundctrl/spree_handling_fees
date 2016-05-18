module Spree
  class Calculator::HandlingFeeCalculator < Calculator::DefaultTax
    def self.description
      Spree.t("handling_fees.calculator_description")
    end

    # This is only here for Spree < 2.2. Spree 2.2+ calculates on shipment and
    # line items rather than order
    def compute_order(_order)
      raise "Spree::Calculator::HandlingFeeCalculator is designed to " \
            "calculate taxes at the line-item level."
    end

    def compute_shipment_or_line_item(item)
      round_to_two_places calculate_handling_fee_for(item)
    end
    alias_method :compute_shipment, :compute_shipment_or_line_item
    alias_method :compute_line_item, :compute_shipment_or_line_item

    private

    def calculate_handling_fee_for(item)
      item.handling_fee * item.quantity
    end
  end
end
