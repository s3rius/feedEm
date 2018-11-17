json.extract! merchandise, :id, :seller_id, :name, :description, :price, :cook_time, :created_at, :updated_at
json.url merchandise_url(merchandise, format: :json)
