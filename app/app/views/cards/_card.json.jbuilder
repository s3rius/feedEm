json.extract! card, :id, :customer_id, :number, :cvv, :expire, :created_at, :updated_at
json.url card_url(card, format: :json)
