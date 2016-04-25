class AddHandlingFeeTotalToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :handling_fee_total, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
