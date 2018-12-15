class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :authenticate_customer!, only: %i[show edit update destroy]
  before_action :authenticate_user_or_admin!

  # GET /customers
  # GET /customers.json
  def index
    if not admin_signed_in?
      return redirect_to root_url, alert: 'Not enough power!'
    end
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    if not (admin_signed_in? or @customer.id == current_customer.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    if not (admin_signed_in? or @customer.id == current_customer.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html {redirect_to @customer, notice: 'Customer was successfully created.'}
        format.json {render :show, status: :created, location: @customer}
      else
        format.html {render :new}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    if not (admin_signed_in? or (@customer.id == current_customer.id and customer_params[:id].to_i == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    respond_to do |format|
      if @customer.update(customer_params)
        format.html {redirect_to @customer, notice: 'Customer was successfully updated.'}
        format.json {render :show, status: :ok, location: @customer}
      else
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    if not (admin_signed_in? or @customer.id == current_customer.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @customer.destroy
    respond_to do |format|
      format.html {redirect_to customers_url, notice: 'Customer was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])

    if @customer
      @customer_cards = []
      Card.where(customer_id: @customer.id).each {|card|
        @customer_cards << {
            id: card.id,
            card: card.number.chars.last(4).join
        }
      }

      @customer_orders = Order.joins(:order_items)
                             .where(customer_id: @customer.id)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:username, :password, :password_confirmation, :name, :surname)
  end

  def authenticate_user_or_admin!
    if not signed_in?
      authenticate_customer!
    end
  end
end
