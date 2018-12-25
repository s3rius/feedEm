json.extract! seller, :id, :name, :likes, :dislikes, :auth_token, :created_at, :updated_at
json.url seller_url(seller, format: :json)
