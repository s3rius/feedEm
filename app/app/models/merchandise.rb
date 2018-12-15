class Merchandise < ApplicationRecord
  include PgSearch

  belongs_to :seller
  has_many :order_item, dependent: :destroy

  pg_search_scope :search_by_name,
                  against: :name,
                  using: { tsearch: { prefix: true } },
                  ranked_by: ':trigram'

  validates :name, :price, :cook_time, presence: true

  validates :name, length: { minimum: 3 }

  validates :price, :cook_time, numericality: {
    greater_than_or_equal_to: 0
  }
end
