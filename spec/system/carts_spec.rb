require 'rails_helper'

RSpec.describe 'カート機能のテスト', type: :system do
  describe '削除機能' do
    let(:cart){ create(:cart) }

    before do
      visit cart_path(cart)
    end

    it 'カートを空にするをクリックするとカートが削除される' do
      click_button 'カートを空にする'
      expect(page).to have_content 'カートは現在空です'
    end
  end
end