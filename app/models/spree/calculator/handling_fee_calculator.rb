module Spree
  class Calculator::HandlingFeeCalculator < Calculator::DefaultTax
    def self.description
      Spree.t("handling_fees.calculator_description")
    end

    def compute_order(_order)
      raise "Spree::Calculator::HandlingFeeCalculator is designed to " \
            "calculate taxes at the line-item level."
    end

    def compute_shipment(_shipment)
      raise "Spree::Calculator::HandlingFeeCalculator is designed to " \
            "calculate taxes at the line-item level."
    end

    def compute_line_item(item)
      round_to_two_places calculate_handling_fee_for(item)
    end

    private

    def calculate_handling_fee_for(item)
      item.handling_fee * item.quantity
    end
  end
end
