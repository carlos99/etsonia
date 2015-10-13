class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    # Finding the id in the url
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user
    #Filling the listing id column
    @order.listing_id = @listing.id
    # Field the buyer Id with the id of the currently signed user.
    @order.buyer_id = current_user.id
    #Filling the seller id column
    @order.seller_id = @seller.id

    Stripe.api_key = ENV["stripe_api_key"]
    token = params[:stripeToken]

    begin

      customer = Stripe::Customer.create(source: params[:stripeToken])
 
      charge = Stripe::Charge.create(
        :amount => (@listing.price * 100).floor, 
        :currency => "usd",
        :customer => customer.id
      )

      flash[:notice] = "Thanks for Ordering"
      rescue Stripe::CardError => e
        flash[:danger] = e.message
    end

    transfer = Stripe::Transfer.create(
      :amount => (@listing.price * 95).floor, 
      :currency => "usd",
      :recipient => @seller.recipient
    )

    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url }
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
      params.require(:order).permit(:address, :city, :state)
    end
end
