require "spec_helper"

RSpec.feature "Throughout checkout process", type: :feature do
  let!(:country) { create(:country, name: "United States of America") }
  let!(:state) { create(:state, name: "Alabama", abbr: "AL", country: country) }

  let!(:shipping_method) { create(:shipping_method) }
  let!(:stock_location) { create(:stock_location) }
  let!(:payment_method) { create(:check_payment_method) }
  let!(:zone) { create(:zone) }

  let(:handling_fee_amount) { 1.23 }
  let(:purchase_quantity) { 2 }
  let!(:variant) { create(:variant, handling_fee: handling_fee_amount) }

  before { visit spree.product_path(variant.product) }

  it "displays handling fee is available", js: true do
    # Product detail page
    fill_in "quantity", with: purchase_quantity

    click_button Spree.t(:add_to_cart)

    # Cart
    expect(page).to have_content Spree.t("handling_fees.handling_fee")
    expect(page).to have_content calculated_handling_fee

    click_button Spree.t(:checkout)

    # Login (as a guest)
    fill_in "order_email", with: "me@example.com"

    click_button Spree.t(:continue)

    # Checkout - Address
    fill_in_address

    expect(page).to have_content Spree.t("handling_fees.handling_fee")
    expect(page).to have_content calculated_handling_fee

    click_button Spree.t(:save_and_continue)

    # Checkout - Delivery
    expect(page).to have_content Spree.t("handling_fees.handling_fee")
    expect(page).to have_content calculated_handling_fee

    click_button Spree.t(:save_and_continue)

    # Checkout - Payment
    expect(page).to have_content Spree.t("handling_fees.handling_fee")
    expect(page).to have_content calculated_handling_fee

    click_button Spree.t(:save_and_continue)

    # Complete / Receipt
    expect(current_path).to include spree.order_path(Spree::Order.last)
    expect(page).to have_content Spree.t(:order_processed_successfully)
    expect(page).to have_content Spree.t("handling_fees.handling_fee")
    expect(page).to have_content calculated_handling_fee
  end

  def calculated_handling_fee
    fee = handling_fee_amount * purchase_quantity

    "$#{fee}"
  end

  def fill_in_address
    address = "order_bill_address_attributes"
    fill_in "#{address}_firstname", with: "Ryan"
    fill_in "#{address}_lastname", with: "Bigg"
    fill_in "#{address}_address1", with: "143 Swan Street"
    fill_in "#{address}_city", with: "Richmond"
    select "United States of America", from: "#{address}_country_id"
    select "Alabama", from: "#{address}_state_id"
    fill_in "#{address}_zipcode", with: "12345"
    fill_in "#{address}_phone", with: "(555) 555-5555"
  end
end
