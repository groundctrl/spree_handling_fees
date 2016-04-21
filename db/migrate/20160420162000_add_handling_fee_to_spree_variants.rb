class AddHandlingFeeToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :handling_fee, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
