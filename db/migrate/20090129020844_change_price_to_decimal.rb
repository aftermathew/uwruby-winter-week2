class ChangePriceToDecimal < ActiveRecord::Migration
  def self.up
    change_column(:products, :price,:decimal, :precision => 8, :scale => 2, :default => 0)
  end

  def self.down
    change_column(:products, :price, :integer)
  end
end
