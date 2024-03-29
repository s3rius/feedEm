class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_or_admin!

  def get_customer_cards
    if not customer_signed_in?
      return render json: {status: 'error'}, status: 403
    end

    cards = Card.where(customer_id: current_customer.id)

    result = []

    cards.each { |card|
      result << { id: card.id, card: card.number.chars.last(4).join() }
    }

    render json: {cards: result}
  end

  # GET /cards
  # GET /cards.json
  def index
    if admin_signed_in?
      @cards = Card.all
    elsif customer_signed_in?
      @cards = Card.where(:customer_id => current_customer.id)
    end

    redirect_to root_url, alert: 'Not enough power!'
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    if not (admin_signed_in? or @card.customer.id == current_customer.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # GET /cards/new
  def new
    if not admin_signed_in?
      return redirect_to root_url, alert: 'Not enough power!'
    end
    
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    if not (admin_signed_in? or (customer_signed_in? and @card.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /cards
  # POST /cards.json
  def create
    if not (admin_signed_in? or (customer_signed_in? and card_params[:customer_id].to_i == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @card = Card.new(card_params)
    already_exists = Card.exists?(number: card_params[:number].to_i)

    respond_to do |format|
      if (not already_exists) and @card.save
        format.html { redirect_to @card.customer, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { redirect_to @card.customer, alert: 'Error while creating card.' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if not (admin_signed_in? or (customer_signed_in? and @card.customer_id == current_customer.id and card_params[:customer_id].to_i == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    already_exists = Card.exists?(number: card_params[:number].to_i)

    respond_to do |format|
      if (not already_exists) and @card.update(card_params)
        format.html { redirect_to @card.customer, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { redirect_to @card.customer, alert: 'Error while updating card.' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    if not (admin_signed_in? or (customer_signed_in? and @card.customer.id == current_customer.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:customer_id, :number, :cvv, :expire)
    end

    def authenticate_user_or_admin!
      if not signed_in?
        authenticate_customer!
      end
    end
end
