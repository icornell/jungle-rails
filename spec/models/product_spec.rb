require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    # validation tests/examples here
    it 'saves successfully when all four fields are set' do
      category = Category.create(name: 'Some Category')
      product = Product.new(
        name: 'Example Product',
        price: 5.99,
        quantity: 3,
        category: category
      )
      expect(product).to be_valid
    end

    it 'validates presence of name' do
      category = Category.create(name: 'Some Category')
      product = Product.new(
        price: 5.99,
        quantity: 3,
        category: category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      category = Category.create(name: 'Some Category')
      product = Product.new(
        name: 'Example Product',
        quantity: 3,
        category: category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates presence of quantity' do
      category = Category.create(name: 'Some Category')
      product = Product.new(
        name: 'Example Product',
        price: 5.99,
        category: category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      product = Product.new(
        name: 'Example Product',
        price: 5.99,
        quantity: 3
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end