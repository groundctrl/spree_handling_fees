Spree::Admin::ReportsController.class_eval do
  module ReportsControllerHandlingFee
    def sales_total
      super

      @orders.each do |order|
        totals_currency = @totals[order.currency]

        totals_currency[:handling_fee_total] ||= ::Money.new(0, order.currency)

        totals_currency[:handling_fee_total] += order.display_handling_fee_total
                                                     .money
      end
    end
  end

  prepend ReportsControllerHandlingFee
end
