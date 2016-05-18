class AddHandlingFeeToSpreeShipments < ActiveRecord::Migration
  def change
    add_column :spree_shipments, :handling_fee, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
