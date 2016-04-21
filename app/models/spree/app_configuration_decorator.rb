Spree::AppConfiguration.class_eval do
  preference :handling_fee, :decimal, default: 0.0
end
