Spree::Variant.class_eval do
  after_initialize :assign_default_handling_fee, if: "new_record?"

  validates :handling_fee, presence: true,
                           numericality: { greater_than_or_equal_to: 0 }

  protected

  def assign_default_handling_fee
    self.handling_fee = Spree::Config.handling_fee
  end
end
