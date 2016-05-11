require "spec_helper"

RSpec.feature "Handling fee tax creation", type: :feature do
  stub_authorization!

  let!(:zone) { create(:zone) }
  let!(:tax_category) { create(:tax_category) }
  let!(:tax_rate_name) { "Handling fee" }

  before { visit spree.new_admin_tax_rate_path }

  describe "with valid handling fee tax" do
    it "submits successfully" do
      fill_in "tax_rate_name", with: tax_rate_name
      select zone.name, from: "tax_rate_zone_id"
      fill_in "tax_rate_amount", with: "1"
      select tax_category.name, from: "tax_rate_tax_category_id"
      uncheck "tax_rate_included_in_price"
      uncheck "tax_rate_show_rate_in_label"
      select Spree.t("handling_fees.calculator_description"), from: "calc_type"

      click_button Spree.t("actions.create")

      expect(page).to have_content("has been successfully created!")
      within_row(1) do
        expect(page).to have_content zone.name
        expect(page).to have_content tax_rate_name
        expect(page).to have_content tax_category.name
        expect(page).to have_content "0.0"
        expect(page).to have_content "Spree/Handling Fee Calculator"
        expect(page).not_to have_content "Yes"
      end
    end
  end

  describe "with invalid handling fee tax" do
    it "fails to submit with errors" do
      fill_in "tax_rate_name", with: tax_rate_name
      select zone.name, from: "tax_rate_zone_id"
      fill_in "tax_rate_amount", with: "1"
      select tax_category.name, from: "tax_rate_tax_category_id"
      check "tax_rate_included_in_price"
      check "tax_rate_show_rate_in_label"
      select Spree.t("handling_fees.calculator_description"), from: "calc_type"

      click_button Spree.t("actions.create")

      expect(page).to have_content(
        Spree.t("handling_fees.validation.included_in_price")
      )
      expect(page).to have_content(
        Spree.t("handling_fees.validation.show_rate_in_label")
      )
    end
  end
end
