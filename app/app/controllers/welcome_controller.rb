class WelcomeController < ApplicationController
  def index
  end

  def merch
    @merchandises = Merchandise.all
  end

  def sellers
  end
end
