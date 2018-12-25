class WelcomeController < ApplicationController
  def index
    @merchandises = Merchandise.includes(:seller)

    @merchandises = @merchandises.map { |merch|
      res = merch.attributes
      res[:seller] = merch.seller
      res
    }
    @merchandises.reverse!

    @sellers = []

    Seller.all.sort_by { |seller|
      (seller.likes - seller.dislikes + 4)/(seller.likes + seller.dislikes + 2)
    }.each do |seller|
      @sellers << {
        id: seller.id,
        name: seller.name,
        likes: seller.likes,
        dislikes: seller.dislikes
      }
    end
  end

  def merch
    @merchandises = Merchandise.all
  end

  def sellers
    @sellers = []

    Seller.all.sort_by { |seller|
      (seller.likes - seller.dislikes + 4)/(seller.likes + seller.dislikes + 2)
    }.reverse.each do |seller|
      @sellers << {
        id: seller.id,
        name: seller.name,
        likes: seller.likes,
        dislikes: seller.dislikes
      }
    end
  end
end
