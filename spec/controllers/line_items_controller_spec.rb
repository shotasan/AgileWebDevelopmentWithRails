require 'rails_helper'

RSpec.describe LineItemsController, type: :controller do
  describe 'Create' do
    let(:product){ create(:product) }
    let(:line_item){ build(:line_item) }

    it '新規作成' do
      expect do
        post :create, params: { product_id: product.id, cart_id: line_item.cart_id }
      end.to change(LineItem, :count).by(1)
    end

    it '作成後にリダイレクトする' do
      post :create, params: { product_id: product.id, cart_id: line_item.cart_id }
      expect(response).to redirect_to(store_path)
    end

    it 'ajaxでの新規作成' do
      post :create, xhr: true, params: { product_id: product.id, cart_id: line_item.cart_id }
      expect(response).to be_successful
    end
  end

end
