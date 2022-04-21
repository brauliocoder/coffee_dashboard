class Order < ApplicationRecord
  belongs_to :coffee_list, counter_cache: true
end
