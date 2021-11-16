require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should create a product if all the fields are valid' do
      @category = Category.new(name: 'Test')
      @product = Product.new(
        name: 'Test Name',
        price_cents: 100,
        quantity: 1,
        category: @category
      )
      expect(@product.valid?).to be(true)
    end

    it 'should not create a product if the name is blank' do
      @category = Category.new(name: 'Test')
      @product = Product.new(
        name: nil,
        price_cents: 100,
        quantity: 1,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:name]).to match(["can't be blank"])
    end

    it 'should not create a product if the price is blank' do
      @category = Category.new(name: 'Test')
      @product = Product.new(
        name: 'Test Name',
        price_cents: nil,
        quantity: 11,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:price_cents]).to match(["is not a number"])
    end

    it 'should not create a product if the quantity is blank' do
      @category = Category.new(name: 'Test category')
      @product = Product.new(
        name: 'Test Name',
        price_cents: 100,
        quantity: nil,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:quantity]).to match(["can't be blank"])
    end

    it 'should not create a product if the category is blank' do
      @product = Product.new(
        name: 'Test Name',
        price_cents: 100,
        quantity: 11,
        category: nil
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:category]).to match(["can't be blank"])
    end

  end
end
end