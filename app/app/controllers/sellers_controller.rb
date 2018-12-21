class SellersController < ApplicationController
  before_action :set_seller, only: %i[show edit update destroy liked disliked]
  before_action :authenticate_user_or_admin!, only: %i[index edit new edit create update destroy liked disliked]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show; end

  # GET /sellers/new
  def new
    if not admin_signed_in?
      redirect_to root_url, alert: 'Not enough power!'
    end

    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
    if not admin_signed_in?
      redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /sellers
  # POST /sellers.json
  def create
    if not admin_signed_in?
      redirect_to root_url, alert: 'Not enough power!'
    end

    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to @seller, notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    if not (admin_signed_in? or (seller_logged_in? and @seller.id == current_seller.id and seller_params[:id].to_i == current_seller.id))
      redirect_to root_url, alert: 'Not enough power!'
    end

    respond_to do |format|
      if @seller.update(seller_params)
        format.html do
          redirect_to @seller,
                      notice: 'Seller was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @seller
        end
      else
        format.html { render :edit }
        format.json do
          render json: @seller.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    if not admin_signed_in?
      redirect_to root_url, alert: 'Not enough power!'
    end

    @seller.destroy
    respond_to do |format|
      format.html do
        redirect_to sellers_url, notice:
            'Seller was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def liked
    if seller_logged_in? and current_seller.id == @seller.id
      return
    end

    @seller.likes += 1
    @seller.save

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_url)
      end
      format.json { head :no_content }
    end
  end

  def disliked
    if seller_logged_in? and current_seller.id == @seller.id
      return
    end

    @seller.dislikes += 1
    @seller.save

    respond_to do |format|
      format.html do
        redirect_back(fallback_location: root_url)
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_seller
    @seller = Seller.find(params[:id])

    if @seller
      @seller_orders = [] 

      Order.where(customer_id: @seller.id).each { |order| 
        @seller_orders << {
          seller_id: order.seller.id,
          customer_id: order.customer.id,
          seller_name: order.seller.name,
          status: order.status,
          time: order.time,
          items: OrderItem.select("*").where(order_id: order.id).joins(:merchandise)
        }
      }
      @seller_merchandises = Merchandise.where(seller_id: @seller.id)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def seller_params
    params.require(:seller).permit(:name, :likes, :dislikes, :auth_token)
  end

  def authenticate_user_or_admin!
    if not (signed_in? or seller_logged_in?)
      authenticate_customer!
    end
  end
end
