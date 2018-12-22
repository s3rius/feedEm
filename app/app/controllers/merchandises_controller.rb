class MerchandisesController < ApplicationController
  before_action :set_merchandise, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_or_admin!, only: [:index, :new, :edit, :create, :update, :destroy]

  # GET /merchandises
  # GET /merchandises.json
  def index
    if admin_signed_in?
      @merchandises = Merchandise.all
    else
      @merchandises = Merchandise.where(:seller_id => current_seller.id)
    end
  end

  # GET /merchandises/1
  # GET /merchandises/1.json
  def show
  end

  # GET /merchandises/new
  def new
    @merchandise = Merchandise.new
  end

  # GET /merchandises/1/edit
  def edit
    if not (admin_signed_in? or @merchandise.seller.id == current_seller.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end
  end

  # POST /merchandises
  # POST /merchandises.json
  def create
    if not (admin_signed_in? or merchandise_params[:seller_id].to_i == current_seller.id)
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @merchandise = Merchandise.new(merchandise_params)

    respond_to do |format|
      if @merchandise.save
        format.html { redirect_to @merchandise, notice: 'Merchandise was successfully created.' }
        format.json { render :show, status: :created, location: @merchandise }
      else
        format.html { render :new }
        format.json { render json: @merchandise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchandises/1
  # PATCH/PUT /merchandises/1.json
  def update
    if not (admin_signed_in? or (seller_logged_in? and @merchandise.seller_id.id == current_seller.id and merchandise_params[:seller_id].to_i == current_seller.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    respond_to do |format|
      if @merchandise.update(merchandise_params)
        format.html { redirect_to @merchandise, notice: 'Merchandise was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchandise }
      else
        format.html { render :edit }
        format.json { render json: @merchandise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchandises/1
  # DELETE /merchandises/1.json
  def destroy
    if not (admin_signed_in? or (seller_logged_in? and @merchandise.seller.id == current_seller.id))
      return redirect_to root_url, alert: 'Not enough power!'
    end

    @merchandise.destroy
    respond_to do |format|
      format.html { redirect_to merchandises_url, notice: 'Merchandise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchandise
      @merchandise = Merchandise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchandise_params
      params.require(:merchandise).permit(:seller_id, :name, :description, :price, :cook_time)
    end

    def authenticate_user_or_admin!
      if not (admin_signed_in? or seller_logged_in?)
        return redirect_to root_url, alert: 'Not enough power!'
      end
    end
end
