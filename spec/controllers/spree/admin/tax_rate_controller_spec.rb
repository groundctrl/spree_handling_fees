require "spec_helper"

RSpec.describe Spree::Admin::TaxRatesController, type: :controller do
  stub_authorization!

  describe "POST #create" do
    context "with valid params" do
      let(:params) { tax_rate_params }

      it "creates a new tax rate" do
        expect do
          spree_post :create, tax_rate: params
        end.to change(Spree::TaxRate, :count).by(1)
      end

      it "assigns a newly created tax rate as @tax_rate" do
        spree_post :create, tax_rate: params

        expect(assigns(:tax_rate)).to be_a(Spree::TaxRate)
        expect(assigns(:tax_rate)).to be_persisted
      end
    end

    context "with invalid params" do
      let(:params) do
        tax_rate_params.merge(
          included_in_price: true,
          show_rate_in_label: true
        )
      end

      it "assigns a newly created but unsaved tax rate as @tax_rate" do
        spree_post :create, tax_rate: params

        expect(assigns(:tax_rate)).to be_a_new(Spree::TaxRate)
      end

      it "re-renders the 'new' template" do
        spree_post :create, tax_rate: params

        expect(response).to render_template(:new)
      end
    end
  end

  def tax_rate_params
    {
      name: "Handling fee",
      zone_id: create(:zone),
      amount: 1,
      tax_category_id: create(:tax_category),
      included_in_price: false,
      show_rate_in_label: false,
      calculator_type: "Spree::Calculator::HandlingFeeCalculator"
    }
  end
end
