Spree::Product.class_eval do
  delegate_belongs_to :master, :handling_fee
end
