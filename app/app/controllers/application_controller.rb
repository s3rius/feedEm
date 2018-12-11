class ApplicationController < ActionController::Base
  helper_method :current_seller
  helper_method :seller_logged_in?

  def current_seller
    @current_seller = nil
    if session[:seller_id]
      @current_seller ||= Seller.find(session[:seller_id])
    end
    @current_seller
  end

  def seller_logged_in?
    not current_seller.nil?
  end
end
