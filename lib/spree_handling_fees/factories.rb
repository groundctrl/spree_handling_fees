FactoryGirl.define do
  factory :handling_fee_calculator,
          class: Spree::Calculator::HandlingFeeCalculator do
  end

  factory :handling_fee_tax, parent: :tax_rate do
    zone
    amount 0
    tax_category
    included_in_price false
    show_rate_in_label false
    association(:calculator, factory: :handling_fee_calculator)
  end
end
