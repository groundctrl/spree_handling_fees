Spree::TaxRate.class_eval do
  before_validation :reset_amount
  validate :handling_fee_included_in_price,
           :handling_fee_show_rate_in_label

  protected

  def reset_amount
    self.amount = 0 if handling_fee_calculator?
  end

  def handling_fee_included_in_price
    if handling_fee_calculator? && included_in_price == true
      errors.add :included_in_price,
                 Spree.t("handling_fees.validation.included_in_price")
    end
  end

  def handling_fee_show_rate_in_label
    if handling_fee_calculator? && show_rate_in_label == true
      errors.add :show_rate_in_label,
                 Spree.t("handling_fees.validation.show_rate_in_label")
    end
  end

  def handling_fee_calculator?
    calculator_type == "Spree::Calculator::HandlingFeeCalculator"
  end
end
