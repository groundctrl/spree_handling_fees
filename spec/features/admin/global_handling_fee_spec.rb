require "spec_helper"

RSpec.feature "Handling fee", type: :feature do
  stub_authorization!

  before { visit spree.edit_admin_general_settings_path }

  after { Spree::Config.handling_fee = 0 }

  it "previously set handling fee is available" do
    Spree::Config.handling_fee = 2.15

    visit spree.edit_admin_general_settings_path

    expect(page).to have_field(Spree.t("handling_fees.handling_fee"),
                               with: "2.15")
  end

  describe "with valid handling fee" do
    it "submits successfully" do
      fill_in "handling_fee", with: 2.15

      click_button Spree.t("actions.update")

      expect(page).to have_content("has been successfully updated!")
      expect(Spree::Config.handling_fee).to eq 2.15
    end
  end

  describe "with non-numeric handling fee" do
    it "sets handling fee to 0" do
      fill_in "handling_fee", with: "foo"

      click_button Spree.t("actions.update")

      expect(page).to have_content("has been successfully updated!")
      expect(Spree::Config.handling_fee).to eq 0
    end
  end
end
