class Merchandise < ApplicationRecord
  belongs_to :seller
  has_many :order_item, dependent: :destroy
end
