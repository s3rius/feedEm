class Merchandise < ApplicationRecord
  include PgSearch

  belongs_to :seller
  has_many :order_item, dependent: :destroy

  pg_search_scope :search_by_name,
                  against: :name,
                  using: { tsearch: { prefix: true } },
		  ranked_by: ':trigram'
end
