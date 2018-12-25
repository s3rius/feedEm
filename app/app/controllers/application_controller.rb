class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
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

  protected

  def configure_permitted_parameters
    if resource_class == Customer
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
    end
  end
end
