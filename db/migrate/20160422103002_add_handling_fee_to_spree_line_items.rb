class AddHandlingFeeToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :handling_fee, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
