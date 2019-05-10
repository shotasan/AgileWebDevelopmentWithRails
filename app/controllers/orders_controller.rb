class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: %w[new create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: 'カートは空です'
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # 新しいOrderオブジェクトの作成
    @order = Order.new(order_params)
    # cart_idをnilにして、商品情報だけをline_itemsとして返す
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      # @orderをsaveするとオーダー情報（名前、Email等）の新規登録と
      # add_line_items_from_cartで取得されたline_itemsが更新され、order_idが登録される
      if @order.save
        # カートを削除してsessionも空にする
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.received(@order).deliver
        format.html { redirect_to store_url, notice: 'ご注文ありがとうございます' }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
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
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
