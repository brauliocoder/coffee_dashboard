json.extract! coffee_list, :id, :name, :origin, :price, :created_at, :updated_at
json.url coffee_list_url(coffee_list, format: :json)
