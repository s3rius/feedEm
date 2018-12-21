require 'date'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_or_admin!

  def add_order
    if customer_signed_in?
      customer_card = params[:card]
      customer_order = params[:order]

      if customer_card.nil? or customer_order.nil?
        return render json: {status: 'error'}, status: 403
      end

      customer_card = customer_card.to_i

      if customer_card <= 0
        return render json: {status: 'error'}, status: 403
      end

      if current_customer.id != Card.find(customer_card).customer_id
        return render json: {status: 'error'}, status: 401
      end

      customer_order_items = customer_order[:items]
      seller_id = customer_order[:seller_id]

      total_time = customer_order_items.map { |item|
        item[:cook_time].to_i
      }.inject(:+)

      end_time = total_time.minutes.from_now

      ActiveRecord::Base.transaction do
        customer_order = Order.create! customer_id: current_customer.id, time: end_time, card_id: customer_card, status: "open", seller_id: seller_id

        customer_order_items.map { |item|
          OrderItem.create! order: customer_order, merchandise_id: item[:id].to_i, quantity: item[:quantity].to_i
        }
      end

      return render json: {status: 'ok'}
    elsif admin_signed_in?
      return redirect_to root_url, alert: 'Admins can not order'
    else
      return redirect_to root_url, alert: 'Sellers can not order'
    end
  end

  def order_ready
    if customer_signed_in?
      return redirect_to root_url, alert: 'Customers can not set order status to ready'
    elsif admin_signed_in? or seller_logged_in?
      order_id = params[:order_id]

      if order_id.nil?
        return render json: {status: 'error'}, status: 403
      end

      order_id = order_id.to_i

      if order_id <= 0
        return render json: {status: 'error'}, status: 403
      end

      order = Order.find(order_id)

      if not (admin_signed_in? or order.seller.id == current_seller.id)
        return render json: {status: 'error'}, status: 401
      end

      if order.status != "open"
        return render json: {status: 'error'}, status: 403
      end

      order.status = "ready"
      orver.save!
    else
        return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  def order_close
    order_id = params[:order_id]

    if order_id.nil?
      return render json: {status: 'error'}, status: 403
    end

    order_id = order_id.to_i

    if order_id <= 0
      return render json: {status: 'error'}, status: 403
    end

    order = Order.find(order_id)

    if admin_signed_in?
      order.status = "closed"
    elsif customer_signed_in?
      if order.customer.id != current_customer.id
        return render json: {status: 'error'}, status: 401
      end

      order.status = "closed"
    elsif seller_logged_in?
      if order.seller.id != current_seller.id
        return render json: {status: 'error'}, status: 401
      end

      order.status = "closed"
    end
  end

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
