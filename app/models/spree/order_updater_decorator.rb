Spree::OrderUpdater.class_eval do
  module OrderUpdaterHandlingFee
    def update_order_total
      super

      order.total += order.handling_fee_total
    end

    def update_totals
      super

      update_handling_fee_total
    end

    def persist_totals
      super

      order.update_columns(
        handling_fee_total: order.handling_fee_total,
        updated_at: Time.current
      )
    end

    def update_handling_fee_total
      order.handling_fee_total = line_items.sum("handling_fee * quantity")

      update_order_total
    end
  end

  prepend OrderUpdaterHandlingFee
end
