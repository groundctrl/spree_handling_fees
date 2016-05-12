module SpreeHandlingFees
  class Engine < Rails::Engine
    require "spree/core"

    isolate_namespace Spree
    engine_name "spree_handling_fees"

    config.generators { |gen| gen.test_framework :rspec }

    initializer "spree_handling_fees.permitted_attributes" do |_app|
      # Add `handling_fee` as a permitted attribute for `spree_variants`
      Spree::PermittedAttributes.variant_attributes.push :handling_fee
    end

    initializer "spree_handling_fees.calculators.tax_rates" do |app|
      app.config.spree.calculators.tax_rates <<
        Spree::Calculator::HandlingFeeCalculator
    end

    def self.activate
      Dir[File.join(__dir__, "../../app/**/*_decorator*.rb")].each do |klass|
        Rails.application.config.cache_classes ? require(klass) : load(klass)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
