class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_or_admin!

  # GET /order_items
  # GET /order_items.json
  def index
    if admin_signed_in?
      @order_items = OrderItem.all
    elsif seller_logged_in?
      @order_items = OrderItem.joins(:order)
                              .where(:orders => {:seller_id => current_seller.id})
    else
      @order_items = OrderItem.joins(:order)
                              .where(:orders => {:customer_id => current_customer.id})
    end
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show
    if not (admin_signed_in? or (seller_logged_in? and @order_item.order.seller.id == current_seller.id) or (customer_signed_in? and @order_item.order.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
    if not (admin_signed_in? or (seller_logged_in? and @order_item.order.seller.id == current_seller.id) or (customer_signed_in? and @order_item.order.customer.id == current_customer.id))
        return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /order_items
  # POST /order_items.json
  def create
    if not (admin_signed_in? or seller_logged_in? or customer_signed_in?)
        return redirect_to root_url, alert: 'Not enough power!'
    end
    
    @order_item = OrderItem.new(order_item_params)

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to @order_item, notice: 'Order item was successfully created.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    if not (admin_signed_in? or (seller_logged_in? and @order_item.order.seller.id == current_seller.id) or (customer_signed_in? and @order_item.order.customer.id == current_customer.id))
        return redirect_to root_url, alert: 'Not enough power!'
    end

    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    if not (admin_signed_in? or (seller_logged_in? and @order_item.order.seller.id == current_seller.id) or (customer_signed_in? and @order_item.order.customer.id == current_customer.id))
        return redirect_to root_url, alert: 'Not enough power!'
    end

    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:order_id, :merchandise_id, :quantity)
    end

    def authenticate_user_or_admin!
      if not (admin_signed_in? or seller_logged_in?)
        authenticate_customer!
      end
    end
end
