class Card < ApplicationRecord
  belongs_to :customer

  validates :number, :cvv, :expire, presence: true

  validates :number, format: { with: /[0-9]{16,16}/}

  validates :cvv, numericality: {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to    => 9999
  }
end
