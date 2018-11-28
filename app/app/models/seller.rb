class Seller < ApplicationRecord
  include PgSearch

  has_secure_token :auth_token
  has_many :merchandise, dependent: :destroy

  pg_search_scope :search_by_name, :against => :name
end
