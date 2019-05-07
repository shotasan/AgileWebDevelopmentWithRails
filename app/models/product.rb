class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_bu_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10, too_short: 'は最低10文字以上入力してください' }
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)\z}i,
      message: 'はGIF,JPG,PNG画像のURLでなければなりません'
  }

  private

  def ensure_not_referenced_bu_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, '品目が存在します')
      false
    end
  end
end
