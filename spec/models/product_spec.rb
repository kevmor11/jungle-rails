require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new(name: 'category')
    @product = Product.new(name: "product", price_cents: 10, quantity: 2, category: @category)
  end    
    
  it 'should check if the product is created' do
    expect(@product).to be_valid
  end

  it 'should not create a product with an invalid name' do
    @product.name = nil
    expect(@product.valid?).to be false
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end
  
  it 'should not create a product with an invalid price' do
    @product.price_cents = nil
    expect(@product.valid?).to be false
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  it 'should not create a product with an invalid quantity' do
    @product.quantity = nil
    expect(@product.valid?).to be false
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

  it 'should not create a product with an invalid category' do
    @product.category = nil
    expect(@product.valid?).to be false
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end
    
end
