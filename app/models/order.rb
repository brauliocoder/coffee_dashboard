class Order < ApplicationRecord
  belongs_to :coffee_list, counter_cache: true

  scope :last_this_months, -> (m) { where("created_at >= ?", (DateTime.now - m.months))}
end
