class StoreController < ApplicationController
  def index
    @products = Product.order(:title)

    if session[:counter].nil?
      session[:counter] = 1
      @counter = session[:counter]
    else
      session[:counter] += 1
      @counter = session[:counter]
    end
  end
end
