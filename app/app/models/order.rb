class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :seller
  has_many :order_item, dependent: :destroy

  def card
  	Card.find(card_id)
  end
end
