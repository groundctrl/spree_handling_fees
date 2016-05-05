require "spec_helper"

RSpec.feature "Reports", type: :feature do
  stub_authorization!

  describe "visiting the admin reports page" do
    it "should have handling fee header" do
      visit spree.admin_reports_path

      click_link "Sales Total"

      expect(page).to have_content Spree.t("handling_fees.handling_fee_total")
    end
  end

  describe "searching the admin reports page" do
    let(:fee) { 3.14 }

    before do
      # Current order
      order = create(:order)
      order.update_columns(handling_fee_total: fee)
      order.completed_at = Time.now
      order.save!

      # Incomplete order
      order = create(:order)
      order.update_columns(handling_fee_total: fee)
      order.save!

      # Past order
      order = create(:order)
      order.update_columns(handling_fee_total: fee)
      order.completed_at = 3.months.ago
      order.created_at = 3.months.ago
      order.save!

      # Future order
      order = create(:order)
      order.update_columns(handling_fee_total: fee)
      order.completed_at = 3.months.from_now
      order.created_at = 3.months.from_now
      order.save!
    end

    it "should allow me to search for reports" do
      visit spree.admin_reports_path

      click_link "Sales Total"

      fill_in "q_completed_at_gt", with: 1.week.ago
      fill_in "q_completed_at_lt", with: 1.week.from_now

      click_button "Search"

      expect(page).to have_content "$#{fee}"
    end
  end
end
