require "spec_helper"

RSpec.feature "Products with variant(s)", type: :feature do
  stub_authorization!

  let!(:variant) { create(:variant) }

  before do
    visit spree.edit_admin_product_variant_path(variant.product, variant)
  end

  after { Spree::Config.handling_fee = 0 }

  describe "with valid handling fee" do
    it "submits successfully" do
      fill_in "variant_handling_fee", with: 2.15

      click_button Spree.t("actions.update")

      variant.reload

      expect(page).to have_content("has been successfully updated!")
      expect(variant.handling_fee).to eq 2.15
    end
  end

  describe "with non-numeric handling fee" do
    it "fails to submit with error" do
      fill_in "variant_handling_fee", with: "foo"

      click_button Spree.t("actions.update")

      expect(page).to have_content("Handling fee is not a number")
    end
  end

  describe "with numeric number handling fee less than 0" do
    it "fails to submit with error" do
      fill_in "variant_handling_fee", with: "-1"

      click_button Spree.t("actions.update")

      expect(page).to(
        have_content("Handling fee must be greater than or equal to 0")
      )
    end
  end
end
