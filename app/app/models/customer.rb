class Customer < ApplicationRecord
  has_secure_password
  has_many :card, dependent: :delete_all
end
