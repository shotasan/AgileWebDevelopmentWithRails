require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '新規作成のテスト' do
    it 'product attributes must not be empty' do
      product = Product.new
      expect(product).to be_invalid
      expect(product.errors[:title]).to be_any
      expect(product.errors[:description]).to be_any
      expect(product.errors[:price]).to be_any
      expect(product.errors[:image_url]).to be_any
    end

    it 'product price must be positive' do
      product = Product.new(title: "My Book Title",
                            description: "yyy",
                            image_url: "xxx.jpg")
      product.price = -1
      expect(product).to be_invalid
      expect(product.errors[:price].join).to eq "must be greater than or equal to 0.01"

      product.price = 0
      expect(product).to be_invalid
      expect(product.errors[:price].join).to eq "must be greater than or equal to 0.01"

      product.price = 1
      expect(product).to be_valid
    end

    it 'product image_url must be .gif .jpg .png' do
      def new_product(image_url)
        Product.new(title: "My Book Title",
                    description: "yyy",
                    price: 1,
                    image_url: image_url)
      end

      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.JPG http://a.b.c/x/y/zfred.gif }
      bad = %w{ fred.doc fred.gif/more fred.gif.more }

      ok.each do |name|
        expect(new_product(name)).to be_valid, "#{name} shouldn't be invalid"
      end

      bad.each do |name|
        expect(new_product(name)).to be_invalid, "#{name} shouldn't be valid"
      end
    end

    it 'product is not valid without a unique title' do
      product = Product.new( title: create(:product).title,
                             description: "yyy",
                             price: 1,
                             image_url: "fred.gif")

      expect(product.save).to be false
      expect(product.errors[:title].join).to eq "has already been taken"
    end
  end
end
