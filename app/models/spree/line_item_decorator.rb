Spree::LineItem.class_eval do
  before_create :add_handling_fee

  private

  def add_handling_fee
    self.handling_fee = variant.handling_fee
  end
end
