Spree::Order.class_eval do
  def display_handling_fee_total
    Spree::Money.new(handling_fee_total, currency: currency)
  end
end
