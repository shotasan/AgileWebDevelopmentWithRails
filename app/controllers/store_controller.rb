class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    # layoutのrender @cartに値を渡すため
    @cart = current_cart

    if session[:counter].nil?
      session[:counter] = 1
      @counter = session[:counter]
    else
      session[:counter] += 1
      @counter = session[:counter]
    end
  end
end
