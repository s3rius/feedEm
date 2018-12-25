json.extract! customer, :id, :username, :name, :surname, :created_at, :updated_at
json.url customer_url(customer, format: :json)
