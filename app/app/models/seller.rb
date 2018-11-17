class Seller < ApplicationRecord
  has_secure_token :auth_token
  has_many :merchandise, dependent: :destroy
end
