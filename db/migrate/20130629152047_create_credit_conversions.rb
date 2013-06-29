class CreateCreditConversions < ActiveRecord::Migration
  def change
    create_table(:credit_conversions) do |t|
      t.integer  :conversion, :default => 1
      t.timestamps
    end
  end
end
