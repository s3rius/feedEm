class SellerSessionsController < ApplicationController
  def new; end

  def create
    seller = Seller.where(auth_token: params[:token]).first
    if seller
      session[:seller_id] = seller.id
      redirect_to root_url, notice: 'Logged in!'
    else
      redirect_to root_url, alert: 'Invalid token!'
    end
  end

  def destroy
    session[:seller_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
