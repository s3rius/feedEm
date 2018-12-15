class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_or_admin!

  # GET /orders
  # GET /orders.json
  def index
    if admin_signed_in?
      @orders = Order.all
    elsif seller_logged_in?
      @orders = Order.where(:seller_id => current_seller.id)
    else
      @orders = Order.where(:customer_id => current_customer.id)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if not (admin_signed_in? or (seller_logged_in? and @order.seller.id == current_seller.id) or (customer_signed_in? and @order.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    if not (admin_signed_in? or (seller_logged_in? and @order.seller.id == current_seller.id) or (customer_signed_in? and @order.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    if not (admin_signed_in? or seller_logged_in? or customer_signed_in?)
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if not (admin_signed_in? or (seller_logged_in? and @order.seller.id == current_seller.id) or (customer_signed_in? and @order.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if not (admin_signed_in? or (seller_logged_in? and @order.seller.id == current_seller.id) or (customer_signed_in? and @order.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :time)
    end

    def authenticate_user_or_admin!
      if not (signed_in? or seller_logged_in?)
        authenticate_customer!
      end
    end
end
