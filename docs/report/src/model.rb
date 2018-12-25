class Seller < ApplicationRecord
  include PgSearch

  has_secure_token :auth_token
  has_many :merchandise, dependent: :destroy
  has_many :order, dependent: :destroy

  pg_search_scope :search_by_name,
                  against: :name,
                  using: { tsearch: { prefix: true } },
		  ranked_by: ':trigram'

    validates :name, presence: true

    validates :name, length: { minimum: 3 }
end
