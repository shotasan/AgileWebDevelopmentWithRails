class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = %w[現金 クレジットカード 注文書]

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  encrypt(:name, :email)

  # cart→cart_id
  # cart.line_itemsでカートに入れた品目一覧を取得
  # cart_id = nilでカートを削除する時に品目が連動して削除されるのを防ぐため
  # 品目そのものをline_itemsコレクションに追加
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
