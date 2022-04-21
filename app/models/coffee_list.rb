class CoffeeList < ApplicationRecord
  has_many :orders, dependent: :destroy

  scope :popular_coffee, -> (sells = 3) { where("orders_count >= ?", sells)}
end
