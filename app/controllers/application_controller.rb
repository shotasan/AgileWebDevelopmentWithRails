class ApplicationController < ActionController::Base

  private

  # sessionからcartの有無を確認し、なければ新規に作成する
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
