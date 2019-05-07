require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'Delete' do
    let!(:cart){ create(:cart) }

    it 'カートを削除する' do
      expect do
        delete :destroy, params: {id: cart.id}
      end.to change(Cart, :count).by(-1)
    end

    it '削除後にリダイレクトする' do
      delete :destroy, params: {id: cart.id}
      expect(response).to redirect_to(carts_path)
    end
  end
end
