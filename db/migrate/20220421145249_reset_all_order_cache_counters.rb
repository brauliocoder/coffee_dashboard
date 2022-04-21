class ResetAllOrderCacheCounters < ActiveRecord::Migration[6.1]
  def up
    Order.all.each do |order|
      Order.reset_counters(order.id, :orders)
    end
  end
  def down
    
  end
  
end
