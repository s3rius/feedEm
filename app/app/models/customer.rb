class Customer < ApplicationRecord
  has_secure_password
  has_many :card, dependent: :destroy
  has_many :order, dependent: :destroy
end
