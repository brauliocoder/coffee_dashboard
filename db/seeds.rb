# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

until CoffeeList.count == 100
  coffee_name = Faker::Coffee.blend_name
  if !CoffeeList.exists?(name: coffee_name)
    CoffeeList.create(
      name: coffee_name, 
      origin: Faker::Coffee.origin, 
      price: rand(1990..5490),
      created_at: DateTime.new(2017, 1, 1),
      updated_at: DateTime.new(2017, 1, 1)
    )
  end
end

calendar = {
  1   =>  31,
  2   =>  28,
  3   =>  31,
  4   =>  30,
  5   =>  31,
  6   =>  30,
  7   =>  31,
  8   =>  31,
  9   =>  30,
  10  =>  31,
  11  =>  30,
  12  =>  31
}

datetime_now = DateTime.now
coffee_available = CoffeeList.count
coffee_ids = CoffeeList.pluck(:id)
mean_price = 0

CoffeeList.all.each do |coffee|
  mean_price += coffee.price
end
mean_price = mean_price / coffee_available

2500.times do
  year = rand(2017..datetime_now.year)
  month = rand(1..12)
  day = rand(1..calendar[month])
  hour = rand(0..23)
  minute = rand(0..59)
  second = rand(0..59)

  time_stamp = DateTime.new(year, month, day, hour, minute, second)
  if time_stamp > datetime_now
    time_stamp = datetime_now - rand(1..45)
  end

  order = Order.new(created_at: time_stamp, updated_at: time_stamp)

  case rand(1..15)
  # 7% buyers do not care about price and purchase a HIGHER order
  when 1
    order.coffee_list_id = coffee_ids[rand(0...coffee_available)]
    
    # there's a 20% chance to buy more than 5 units but no more than 25 units
    case rand(1..5)
    when 1
      order.quantity = rand(6..25)
    when 2..5
      order.quantity = rand(1..5)
    end

    order.save
    
  # 13% buyers purchase a coffee following early adopters preferences no matter the price
  when 2..3
    option = CoffeeList.order(orders_count: :desc).popular_coffee(1)
    if option.count >= 1
      options_ids = option.pluck(:id)

      order.coffee_list_id = options_ids[rand(0...options_ids.count)]
      order.quantity = rand(1..5)

      order.save
    end

    
  # 27% buyers purchase ONLY most POPULAR coffees with 20 or more sells
  # but at a HIGHER price and LOWER order quantity
  when 4..7
    option = CoffeeList.order(orders_count: :desc).limit(20).popular_coffee(20).where('price > ?', mean_price)
    if option.count >= 1
      options_ids = option.pluck(:id)

      order.coffee_list_id = options_ids[rand(0...options_ids.count)]
      order.quantity = rand(1..5)

      order.save
    end
  # 53% buyers purchase ONLY influenced by POPULAR coffees with the LOWER price 
  # at a LOWER order
  when 8..15
    option = CoffeeList.order(:orders_count).limit(20).popular_coffee(20).where('price < ?', mean_price)
    if option.count >= 1
      options_ids = option.pluck(:id)

      order.coffee_list_id = options_ids[rand(0...options_ids.count)]
      order.quantity = rand(1..5)
      
      order.save
    end
  end
end
