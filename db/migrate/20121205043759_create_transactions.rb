class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer "user_id", :null => false
      t.integer "bike_id"
      t.integer "amount", :null => false
      #Adding whether or not a user sold or purchased the bike
      #could be used to help keep track of external sales.
      #aka, a collective member (user) sold a bike to
      #a non user
      #Currently this model automatically assumes that the user is 
      #purchasing a bike, or a part for a bike from the collective
      #t.boolean "user_sold_flag", :default => false
    end
  end
end
