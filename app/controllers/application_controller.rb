class ApplicationController < ActionController::Base
  before_action :authorize

  private

  # sessionからcartの有無を確認し、なければ新規に作成する
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, notice: 'ログインしてください'
    end
  end
end
